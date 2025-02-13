import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

import '../../database/app_database.dart';
import '../../main.dart';
import '../../pages/home/home_controller.dart';
import '../guid_util.dart';
import 'download_config.dart';
import 'download_config_enums.dart';

class DownloadRunner {
  final String dlPath;
  final DownloadConfig config;

  DownloadRunner({required this.dlPath, required this.config});

  String appPath = Platform.resolvedExecutable;

  String get appDir =>
      appPath.substring(0, appPath.lastIndexOf(Platform.pathSeparator));

  String get ytDlpWinexe =>
      Directory("$appDir\\data\\flutter_assets\\assets\\executable")
          .listSync()
          .where((element) => element.path.endsWith('yt-dlp.exe'))
          .first
          .path;

  String get ytDlpMacos => Directory(
          "$appDir/../Frameworks/App.Framework/Resources/flutter_assets/assets/executable")
      .listSync()
      .where((element) => element.path.endsWith('yt-dlp_macos'))
      .first
      .path;

  // TODO: fix linux
  String get ytDlpLinux =>
      Directory("$appDir/data/flutter_assets/assets/executable")
          .listSync()
          .first
          .path;

  Future<void> run() async {
    var controller = ShellLinesController();

    final shell = Shell(
        workingDirectory: dlPath, stdout: controller.sink, verbose: false);
    final RegExp downloadProgressRegExp = RegExp(r'\[download\]\s+(\d+\.\d+)%');

    RegExp regExp = RegExp(
        r'(\d+\.?\d*)% of ~ (\d+\.?\d*\w+) at\s+(\d+\.?\d*\w+/s) ETA (\d+:\d+) \(frag (\d+)/(\d+)\)');

    var ytDlpPath = '';
    if (Platform.isLinux) ytDlpPath = ytDlpLinux;
    if (Platform.isMacOS) {
      ytDlpPath = ytDlpMacos;
      String permissionCmd = "chmod +x $ytDlpPath";
      await shell.run(permissionCmd);
    }
    if (Platform.isWindows) ytDlpPath = ytDlpWinexe;

    String id = GuidUtil.generateGuid();
    DownloadEntityData entity = await getDownloadEntity(id);
    // listen to stdout
    controller.stream.listen((event) async {
      if (event.startsWith('[download]')) {
        debugPrint(event);
        if (event.contains("Unable to open file")) {
          entity = entity.copyWith(status: DownloadStatus.failed.value);
          saveDownloadEntity(entity);
          return;
        }
        if (event.contains("[download] Destination: ")) {
          entity = entity.copyWith(
              fileName: event.split("[download] Destination: ")[1]);
          saveDownloadEntity(entity);
          return;
        }
        if (event.contains('has already been downloaded') || event.contains('100% of')) {
          entity = entity.copyWith(
              status: DownloadStatus.completed.value,
              fileName: event
                  .split(' has already been downloaded')[0]
                  .replaceAll("[download] ", ""));
          saveDownloadEntity(entity);
          return;
        }
        Match? match = downloadProgressRegExp.firstMatch(event);
        if (match != null && match.group(1) != null) {
          var downloadPercentage = double.parse(match.group(1)!);
          if (downloadPercentage < 100) {
            Match? matchAll = regExp.firstMatch(event);
            if (matchAll == null) return;
            String size = matchAll.group(2) ?? '';
            String speed = matchAll.group(3) ?? '';
            String eta = matchAll.group(4) ?? '';
            String frag = matchAll.group(5) ?? '';
            String totalFrag = matchAll.group(6) ?? '';
            entity = entity.copyWith(
                progress: Value(downloadPercentage),
                totalSize: Value(size),
                status: DownloadStatus.downloading.value,
                speed: Value(speed),
                eta: Value(eta),
                frag: Value(frag),
                totalFrag: Value(totalFrag));
          } else {
            entity = entity.copyWith(
                progress: Value(downloadPercentage),
                status: DownloadStatus.completed.value);
            entity = entity.copyWith();
          }
        }
        saveDownloadEntity(entity);
      } else if (event.startsWith('{')) {
        Map<String, dynamic> json = jsonDecode(event);
        String title = '';
        String thumbnail = '';
        if (json.containsKey('title')) {
          title = json['title'];
        }
        if (json.containsKey('thumbnail')) {
          thumbnail = json['thumbnail'];
        }
        entity = entity.copyWith(title: title);
        entity = entity.copyWith(thumbnail: thumbnail);
        entity = entity.copyWith(status: DownloadStatus.enqueue.value);
        entity = entity.copyWith(
            createdAt: Value(DateTime.now().millisecondsSinceEpoch));
        saveDownloadEntity(entity);
      }
    });
    saveDownloadEntity(entity);

    String detailsCmd = "$ytDlpPath -j ${config.url}";
    await shell.run(detailsCmd);

    String command = buildCommand(config);
    await shell.run("$ytDlpPath $command");
  }

  Future<DownloadEntityData> getDownloadEntity(String id) async {
    final query = db.select(db.downloadEntity)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1);
    DownloadEntityData? data = await query.getSingleOrNull();
    if (data != null) {
      return data;
    }
    DownloadEntityData entity = DownloadEntityData(
      id: id,
      url: config.url,
      title: '',
      thumbnail: '',
      path: dlPath,
      status: DownloadStatus.enqueue.value,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      fileName: '',
    );
    return entity;
  }

  saveDownloadEntity(DownloadEntityData entity) async {
    globalContainer.read(updateProvider.notifier).state = entity;
    await db
        .into(db.downloadEntity)
        .insert(entity, mode: InsertMode.insertOrReplace);
  }

  String buildCommand(DownloadConfig config) {
    StringBuffer command = StringBuffer();
    if (config.dlVideo && config.dlAudio) command.write(" -k");
    if (config.dlAudio) command.write(" -x");
    if (config.dlSubtitles) command.write(" --write-subs");
    if (config.dlThumbnail) command.write(" --write-thumbnail");
    // sponsor block
    if (config.sponsorBlock) command.write(" --sponsorblock-remove all");

    if (config.startTime != null && config.endTime != null) {
      command.write(
          "--download-sections \"*${config.startTime}-${config.endTime}\"");
    }

    // video size and format
    // command.write(" -f \"best[height=${_config.vSize.value}]\"");
    // command.write(" --remux-video \"${_config.vFormat.value}\"");
    // // audio bitrate
    // command.write(" --audio-quality ${_config.aBitrate.value}k");
    // // audio format
    // command.write(" --audio-format ${_config.aFormat.value}");

    command.write(" ${config.url}");

    return command.toString();
  }
}
