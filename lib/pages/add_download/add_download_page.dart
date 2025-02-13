import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_downloader/utils/sp_constant.dart';
import 'package:video_downloader/utils/sp_utils.dart';

import '../../theme/theme_state.dart';
import '../../utils/yt_dlp/download_config.dart';
import '../../utils/yt_dlp/download_runner.dart';
import '../home/home_controller.dart';

class AddDownloadPage extends ConsumerStatefulWidget {
  const AddDownloadPage({super.key});

  @override
  ConsumerState createState() => _AddDownloadPageState();
}

class _AddDownloadPageState extends ConsumerState<AddDownloadPage> {

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _pathController = TextEditingController();

  DownloadConfig config = DownloadConfig.defaultConfig();

  String dlPath = "";

  @override
  void initState() {
    super.initState();
    String path = SpUtils.getString(SpConstant.downloadPath);
    if (path.isNotEmpty) {
      dlPath = path;
      _pathController.text = path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 100,vertical: 50),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: getColor(ref, Color(0xffefefef), Color(0xFF1E1E1E)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('add_download'.tr(), style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('url'.tr(), style: const TextStyle(fontSize: 16)),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              maxLines: 1,
                              controller: _urlController,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                hintText: 'add_download_link'.tr(),
                                hintStyle: TextStyle(color: getColor(ref, Colors.grey, Colors.black54)),
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                hoverColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text('path'.tr(), style: const TextStyle(fontSize: 16)),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              maxLines: 1,
                              controller: _pathController,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                hintText: 'add_path'.tr(),
                                hintStyle: TextStyle(color: getColor(ref, Colors.grey, Colors.black54)),
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                hoverColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.folder, color: Colors.blue,),
                                  onPressed: () {
                                    FilePicker.platform.getDirectoryPath().then(
                                          (value) {
                                        if (value != null) {
                                          _pathController.text = value;
                                          SpUtils.putString(SpConstant.downloadPath, value);
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:  Text('cancel'.tr()),
                ),
                TextButton(
                  onPressed: ()=> _addDownload(),
                  child:  Text('download_now'.tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _addDownload() {
    final url = _urlController.text;
    final path = _pathController.text;
    if (url.isEmpty || path.isEmpty) {
      return;
    }
    config = config.set(url: url);
    DownloadRunner(
      dlPath: dlPath,
      config: config,
    ).run();
    ref.read(homeControllerProvider.notifier).updateSelectedIndex(0);
    Navigator.of(context).pop();
  }
}
