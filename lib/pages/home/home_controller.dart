
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_downloader/database/app_database.dart';

import '../../main.dart';
import '../../utils/yt_dlp/download_config_enums.dart';

part 'home_controller.freezed.dart';

final globalContainer = ProviderContainer();

final homeControllerProvider = AutoDisposeStateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController(ref);
});

final updateProvider = AutoDisposeStateProvider<DownloadEntityData?>((ref) => null);

class HomeController extends StateNotifier<HomeState> {
  HomeController(this.ref)
      : super(const HomeState(
          downloadList: [],
          downloadedList: [],
          version: '',
          expanded: false,
          selectedIndex: 0,
        ));

  final Ref ref;

  void init() async {

    String version = await getVersion();
    state = state.copyWith(version: version);
    final downloadList = await getDownloadList();
    state = state.copyWith(downloadList: downloadList);
    final downloadedList = await getDownloadedList();
    state = state.copyWith(downloadedList: downloadedList);
  }

  updateExpanded(bool expanded) {
    state = state.copyWith(expanded: expanded);
  }

  getDownloadList() async {
    final query = db.select(db.downloadEntity)..where((tbl) => tbl.status.isNotValue(DownloadStatus.completed.value));
    return await query.get();
  }

  getDownloadedList() async {
    final query = db.select(db.downloadEntity)..where((tbl) => tbl.status.equals(DownloadStatus.completed.value));
    return await query.get();
  }

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void updateSelectedIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void updateDownloadList(DownloadEntityData data) {
    if(data.status == DownloadStatus.completed.value) {
      final downloadedList = [...state.downloadedList];
      if (downloadedList.any((element) => element.url == data.url)) {
        final index = downloadedList.indexWhere((element) => element.url == data.url);
        downloadedList[index] = data;
      } else {
        downloadedList.insert(0, data);
      }
      state = state.copyWith(downloadedList: downloadedList);

      final downloadList = [...state.downloadList];
      if (downloadList.any((element) => element.url == data.url)) {
        final index = downloadList.indexWhere((element) => element.url == data.url);
        downloadList.removeAt(index);
      }
      state = state.copyWith(downloadList: downloadList);
    } else {
      final downloadList = [...state.downloadList];
      if (downloadList.any((element) => element.url == data.url)) {
        final index = downloadList.indexWhere((element) =>
        element.url == data.url);
        downloadList[index] = data;
      } else {
        downloadList.insert(0, data);
      }
      state = state.copyWith(downloadList: downloadList);
    }
  }

  Future<void> deleteDownload(DownloadEntityData downloadEntity) async {
    final data = db.delete(db.downloadEntity)..where((tbl) => tbl.id.equals(downloadEntity.id));
    await data.go();
    final downloadList = [...state.downloadList];
    downloadList.removeWhere((element) => element.id == downloadEntity.id);
    state = state.copyWith(downloadList: downloadList);

    final downloadedList = [...state.downloadedList];
    downloadedList.removeWhere((element) => element.id == downloadEntity.id);
    state = state.copyWith(downloadedList: downloadedList);
  }
}
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<DownloadEntityData> downloadList,
    required List<DownloadEntityData> downloadedList,
    required String version,
    required int selectedIndex,
    required bool expanded,
  }) = _HomeState;
}