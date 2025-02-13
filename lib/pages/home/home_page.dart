import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_downloader/database/app_database.dart';

import '../../main.dart';
import '../add_download/add_download_page.dart';
import 'home_controller.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

const animatedDuration = Duration(milliseconds: 300);

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    globalContainer.listen(updateProvider, (oldValue, newValue) {
      if (newValue != null) {
        ref.read(homeControllerProvider.notifier).updateDownloadList(newValue);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeControllerProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildDrawer(),
          Expanded(child: _buildContent()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddDownloadPage();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer() {
    String versionValue = ref.watch(homeControllerProvider).version;
    final expanded = ref.watch(homeControllerProvider).expanded;
    return AnimatedContainer(
      duration: animatedDuration,
      width: expanded ? 200 : 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xefefefef),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (expanded)
                Expanded(
                  child: Text(
                    "${'version_code'.tr()}: $versionValue",
                    maxLines: 1,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              Spacer(),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  ref
                      .read(homeControllerProvider.notifier)
                      .updateExpanded(!expanded);
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          _buildItem(
              title: 'download_list'.tr(),
              icon: Icons.download_rounded,
              index: 0,
              onTap: () {
                ref
                    .read(homeControllerProvider.notifier)
                    .updateSelectedIndex(0);
              }),
          SizedBox(height: 10),
          _buildItem(
              title: 'downloaded'.tr(),
              icon: Icons.download_done_rounded,
              index: 1,
              onTap: () {
                ref
                    .read(homeControllerProvider.notifier)
                    .updateSelectedIndex(1);
              }),
          Spacer(),
          _buildItem(
              title: 'settings'.tr(),
              icon: Icons.settings,
              index: -1,
              onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildItem(
      {required String title,
      required IconData icon,
      required int index,
      Function()? onTap}) {
    final expanded = ref.watch(homeControllerProvider).expanded;
    final selectedIndex = ref.watch(homeControllerProvider).selectedIndex;
    return InkWell(
      onTap: () => onTap?.call(),
      child: Container(
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
            if (expanded)
              Expanded(
                child: AnimatedOpacity(
                    duration: animatedDuration,
                    opacity: expanded ? 1 : 0,
                    child: Text(
                      title,
                      maxLines: 1,
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black),
                    )),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final selectedIndex = ref.watch(homeControllerProvider).selectedIndex;
    if (selectedIndex == 0) {
      return _buildDownloadList();
    } else if (selectedIndex == 1) {
      return _buildDownloaded();
    } else {
      return Container();
    }
  }

  Widget _buildDownloadList() {
    final downloadList = ref.watch(homeControllerProvider).downloadList;
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            SizedBox(
              width: 120,
              height: 60,
              child: downloadList[index].thumbnail.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: downloadList[index].thumbnail,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => _errorImage(),
                        placeholder: (context, url) => _errorImage(),
                      ))
                  : _errorImage(),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(downloadList[index].title.isEmpty
                      ? 'video_analysis'.tr()
                      : downloadList[index].title),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(downloadList[index].totalSize ?? '0b',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ),
                      SizedBox(width: 20),
                      Text(
                          downloadList[index].progress == null
                              ? 'waiting'.tr()
                              : '${'already_downloaded'.tr()}  ${downloadList[index].progress}%',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                      Spacer(),
                      Text(downloadList[index].speed ?? '0b/s',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: downloadList[index].progress == null
                        ? 0
                        : downloadList[index].progress! / 100,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 1,
          color: Color(0xffefefef),
        );
      },
      itemCount: downloadList.length,
    );
  }

  Widget _errorImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildDownloaded() {
    final downloadedList = ref.watch(homeControllerProvider).downloadedList;
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Process.run('open', [downloadedList[index].path]);
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('tip'.tr()),
                  content: Text('delete_confirm'.tr()),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancel'.tr()),
                    ),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(homeControllerProvider.notifier)
                            .deleteDownload(downloadedList[index]);
                        Navigator.pop(context);
                      },
                      child: Text('delete'.tr()),
                    ),
                  ],
                );
              },
            );
          },
          child: Row(
            children: [
              SizedBox(
                width: 120,
                height: 60,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: downloadedList[index].thumbnail.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: downloadedList[index].thumbnail,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => _errorImage(),
                            placeholder: (context, url) => _errorImage(),
                          )
                        : _errorImage()),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(downloadedList[index].title,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10),
                    Text(downloadedList[index].path,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(10),
          height: 2,
          color: Color(0xffefefef),
        );
      },
      itemCount: downloadedList.length,
    );
  }

  _deleteDownload(DownloadEntityData downloadEntity) {}
}
