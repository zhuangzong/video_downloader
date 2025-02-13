import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/theme_state.dart';
import '../../utils/sp_constant.dart';
import '../../utils/sp_utils.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState createState() => _SettingPageState();
}

final languageProvider = StateProvider<String>((ref) {
  String language = SpUtils.getString(SpConstant.language);
  if(language == "en-US") {
    return 'English';
  } else if(language == "zh-CN") {
    return '中文';
  }
  return 'English';
});

final themeProvider = StateProvider<String>((ref) => SpUtils.getString(SpConstant.theme, defValue: "system"));


class _SettingPageState extends ConsumerState<SettingPage> {



  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: getColor(ref, Color(0xffefefef), Color(0xFF1E1E1E)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('settings'.tr(), style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildLanguage(),
                      const SizedBox(height: 16),
                      _buildTheme(),
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
                  child:  Text('close'.tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguage(){
    final language = ref.watch(languageProvider);
    return Row(
      children: [
        Text('language'.tr(), style: const TextStyle(fontSize: 16)),
        const Spacer(),
        DropdownButton<String>(
          value: language,
          onChanged: (String? newValue) async {
            ref.read(languageProvider.notifier).state = newValue!;
            String newLanguage = 'en-US';
            if(newValue == 'English') {
              SpUtils.putString(SpConstant.language, 'en-US');
              newLanguage = 'en-US';
            } else if(newValue == '中文') {
              SpUtils.putString(SpConstant.language, 'zh-CN');
              newLanguage = 'zh-CN';
            }
            await context.setLocale(Locale(
                newLanguage.split("-")[0], newLanguage.split("-")[1]));
            ref.invalidate(themeProvider);
          },
          items: <String>['English', '中文']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
  Widget _buildTheme(){
    final theme = ref.watch(themeProvider);
    return Row(
      children: [
        Text('theme'.tr(), style: const TextStyle(fontSize: 16)),
        const Spacer(),
        DropdownButton<String>(
          value: theme,
          onChanged: (String? value) async {
            if (value == null) return;
            SpUtils.putString(SpConstant.theme, value);
            ref
                .read(themeProvider.notifier)
                .state = value;
            if (value == "system") {
              ref
                  .read(themeNotifierProvider.notifier)
                  .switchTheme(ThemeMode.system);
            } else {
              ref.read(themeNotifierProvider.notifier).switchTheme(
                  value == "light" ? ThemeMode.light : ThemeMode.dark);
            }
          },
          items: <String>['system', 'light', 'dark']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value).tr(),
            );
          }).toList(),
        ),
      ],
    );
  }
}
