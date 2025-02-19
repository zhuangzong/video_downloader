import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../add_download/add_download_page.dart';
import 'package:flutter/services.dart' show rootBundle;

class WebviewPage extends ConsumerStatefulWidget {
  const WebviewPage({super.key});

  @override
  ConsumerState createState() => _WebviewPageState();
}

class _WebviewPageState extends ConsumerState<WebviewPage>
    with TickerProviderStateMixin {
  final TextEditingController _urlController = TextEditingController();
  late TabController _tabController;
  final List<String> _urls = [];
  final List<InAppWebViewController> _controllers = [];
  double progress = 0;
  List<HomepageModel> videoPlatforms = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
    rootBundle.loadString('assets/others/homepage.json').then((value) {
      final data = json.decode(value);
      setState(() {
        videoPlatforms = data['video_platforms']
            .map<HomepageModel>((item) => HomepageModel.fromJson(item))
            .toList();
      });
    });
  }

  void _addNewTab(String url) {
    setState(() {
      _urls.add(url);
      _tabController = TabController(length: _urls.length, vsync: this);
      _tabController.animateTo(_urls.length - 1);
      _urlController.text = url;
    });
  }

  void _removeTab(int index) {
    setState(() {
      _urls.removeAt(index);
      _tabController = TabController(length: _urls.length, vsync: this);
      if (_urls.isNotEmpty) {
        _tabController.animateTo(_tabController.index - 1);
        _urlController.text = _urls[_tabController.index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _urlController,
          decoration: const InputDecoration(
            hintText: '输入网址',
          ),
          onSubmitted: (url) =>
              _addNewTab(url.startsWith('http') ? url : 'https://$url'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.forward),
            onPressed: () => _addNewTab(_urlController.text.startsWith('http')
                ? _urlController.text
                : 'https://${_urlController.text}'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, size: 16),
            onPressed: () {
              if (_tabController.index < _controllers.length) {
                _controllers[_tabController.index].reload();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.download, size: 16),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddDownloadPage(
                    url: _urlController.text,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          if (_urls.isNotEmpty)
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              indicatorWeight: 0,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              onTap: (index) {
                _tabController.animateTo(index);
                _urlController.text = _urls[index];
              },
              tabs: List.generate(
                _urls.length,
                (index) => Row(
                  children: [
                    Text("${'tab'.tr()} ${index + 1}"),
                    IconButton(
                      icon: const Icon(Icons.close, size: 16),
                      onPressed: () => _removeTab(index),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 10),
          Expanded(
            child: _urls.isEmpty
                ? ListView.builder(
                    itemCount: videoPlatforms.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 16),
                            child: Text(videoPlatforms[index].name!),
                          ),
                          Wrap(
                            children: videoPlatforms[index].items
                                .map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ElevatedButton(
                                      onPressed: () => _addNewTab(item.url!),
                                      child: Text(item.name!),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      );
                    },
                  )
                : TabBarView(
                    controller: _tabController,
                    children: _urls
                        .asMap()
                        .keys
                        .map(
                          (index) => Column(
                            children: [
                              Expanded(
                                child: InAppWebView(
                                  initialUrlRequest:
                                      URLRequest(url: WebUri(_urls[index])),
                                  onWebViewCreated: (controller) {
                                    _controllers.add(controller);
                                  },
                                  initialSettings: InAppWebViewSettings(
                                    cacheEnabled: false,
                                  ),
                                  onProgressChanged: (controller, progress) {
                                    setState(() {
                                      this.progress = progress / 100;
                                    });
                                    controller.getUrl().then((url) {
                                      if (index < _controllers.length &&
                                          progress == 100) {
                                        setState(() {
                                          _urls[index] = url.toString();
                                          _urlController.text = url.toString();
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                              if (progress < 1)
                                LinearProgressIndicator(
                                  valueColor:
                                      const AlwaysStoppedAnimation(Colors.blue),
                                  value: progress,
                                ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class HomepageModel {
  final String? name;
  final List<HomeItemModel> items;

  HomepageModel({this.name, required this.items});

  factory HomepageModel.fromJson(Map<String, dynamic> json) {
    return HomepageModel(
      name: json['name'],
      items: json['items']
          .map<HomeItemModel>((item) => HomeItemModel(
                name: item['name'],
                url: item['url'],
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class HomeItemModel {
  String? name;
  String? url;

  HomeItemModel({required this.name, required this.url});

  factory HomeItemModel.fromJson(Map<String, dynamic> json) {
    return HomeItemModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
