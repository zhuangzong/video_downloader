import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:video_downloader/database/app_database.dart';
import 'package:video_downloader/pages/home/keep_alive_wrapper.dart';
import 'package:video_downloader/theme/theme_state.dart';

import '../../main.dart';
import '../../utils/sp_constant.dart';
import '../../utils/sp_utils.dart';
import '../add_download/add_download_page.dart';
import '../settings/setting_page.dart';
import 'home_controller.dart';
import 'webview_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

const animatedDuration = Duration(milliseconds: 300);

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {

  GlobalKey downloadKey = GlobalKey();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
    globalContainer.listen(updateProvider, (oldValue, newValue) {
      if (newValue != null) {
        ref
            .read(homeControllerProvider.notifier)
            .updateDownloadList(context, newValue);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(homeControllerProvider.notifier).init();
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
        onPressed: () async {
          Offset? buttonPosition = await showDialog(
            context: context,
            builder: (context) {
              return const AddDownloadPage();
            },
          );
          if (buttonPosition != null) {
            RenderBox cartBox = downloadKey.currentContext!.findRenderObject() as RenderBox;
            Offset cartPosition = cartBox.localToGlobal(Offset.zero);

            _overlayEntry = _createOverlayEntry(buttonPosition, cartPosition);
            if(context.mounted) {
              Overlay.of(context).insert(_overlayEntry!);
              _controller.forward(from: 0);
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  OverlayEntry _createOverlayEntry(Offset start, Offset end) {
    _offsetAnimation = Tween<Offset>(
      begin: start,
      end: end,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuad,
    ));

    return OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Positioned(
            left: _offsetAnimation.value.dx,
            top: _offsetAnimation.value.dy,
            child: Opacity(
              opacity: 1 - _controller.value,
              child: Transform.scale(
                scale: 1 - (_controller.value * 0.5),
                child: Icon(Icons.shopping_bag, color: Colors.blue, size: 30),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    String versionValue = ref.watch(homeControllerProvider).version;
    final expanded = ref.watch(homeControllerProvider).expanded;
    final downloadList = ref.watch(homeControllerProvider).downloadList;
    return AnimatedContainer(
      duration: animatedDuration,
      width: expanded ? 200 : 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: getColor(ref, Color(0xffefefef), Color(0xFF1E1E1E)),
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
            key: downloadKey,
              title: 'download_list'.tr(),
              showBadge: true,
              badgeCount: downloadList.length,
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
          SizedBox(height: 10),
          _buildItem(
              title: 'webview'.tr(),
              icon: Icons.web_rounded,
              index: 2,
              onTap: () {
                ref
                    .read(homeControllerProvider.notifier)
                    .updateSelectedIndex(2);
              }),
          Spacer(),
          _buildItem(
              title: 'settings'.tr(),
              icon: Icons.settings,
              index: -1,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const SettingPage();
                  },
                );
              }),
        ],
      ),
    );
  }

  Widget _buildItem(
      {required String title,
      required IconData icon,
      required int index,
        bool showBadge = false,
        int badgeCount = 0,
        Key? key,
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
        child: Stack(
          children: [
            Row(
              children: [
                Padding(
                  key: key,
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    icon,
                    color: selectedIndex == index
                        ? Colors.white
                        : getColor(ref, Colors.black, Colors.white),
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
                                  : getColor(ref, Colors.black, Colors.white)),
                        )),
                  ),
              ],
            ),
            Visibility(
              visible: showBadge && badgeCount > 0,
              child: Positioned(
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:  Center(
                    child: Text('$badgeCount', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return PageView(
      controller: ref.read(homeControllerProvider.notifier).pageController,
      scrollDirection: Axis.vertical,
      children: [
        KeepAliveWrapper(_buildDownloadList()),
        KeepAliveWrapper(_buildDownloaded()),
        KeepAliveWrapper(WebviewPage()),
      ],
    );
  }

  Widget _buildDownloadList() {
    final downloadList = ref.watch(homeControllerProvider).downloadList;
    return downloadList.isEmpty ? Center(
      child: Text('no_downloaded'.tr(), style: const TextStyle(color: Colors.grey)),
    ) : ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onLongPress: () => _deleteDownload(downloadList[index]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
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
            ),
          ),
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
    if(downloadedList.isEmpty) {
      return Center(
        child: Text('no_downloaded'.tr(), style: const TextStyle(color: Colors.grey)),
      );
    }
    bool isFilter = ref.watch(homeControllerProvider).filter;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(isFilter ? Icons.filter_alt_off_rounded : Icons.filter_alt_rounded),
            onPressed: () {
              ref.read(homeControllerProvider.notifier).updateFilter(!isFilter);
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Process.run('open', [
                        '${downloadedList[index].path}/${downloadedList[index].fileName}'
                      ]),
                      child: Stack(
                        alignment: Alignment.center,
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
                                  errorWidget: (context, url, error) =>
                                      _errorImage(),
                                  placeholder: (context, url) =>
                                      _errorImage(),
                                )
                                    : _errorImage()),
                          ),
                          Center(
                              child: Icon(Icons.play_circle_outline_rounded,
                                  color: Colors.white.withOpacity(0.8), size: 30)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(downloadedList[index].title,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () =>
                                Process.run('open', [downloadedList[index].path]),
                            child: Text(downloadedList[index].path,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                  decorationThickness: 2.0,
                                )),
                          ),
                        ],
                      ),
                    ),
                    if(isFilter)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteDownload(downloadedList[index]),
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
          ),
        ),
      ],
    );
  }

  _deleteDownload(DownloadEntityData downloadEntity) {
    bool deleteResource = ref.watch(homeControllerProvider).deleteLocal;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('tip'.tr()),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        deleteResource = !deleteResource;
                      });
                      ref
                          .read(homeControllerProvider.notifier)
                          .updateDeleteLocal(deleteResource);
                    },
                      child: Text('delete_confirm'.tr())),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: deleteResource,
                        onChanged: (value) {
                          ref
                              .read(homeControllerProvider.notifier)
                              .updateDeleteLocal(value!);
                          setState(() {
                              deleteResource = value;
                          });
                        },
                      ),
                      Text('delete_resource'.tr()),
                    ],
                  ),
                ],
              );
            }
          ),
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
                    .deleteDownload(downloadEntity);
                Navigator.pop(context);
              },
              child: Text('delete'.tr()),
            ),
          ],
        );
      },
    );
  }
}
