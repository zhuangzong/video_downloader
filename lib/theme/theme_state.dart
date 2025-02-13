import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/sp_constant.dart';
import '../utils/sp_utils.dart';

part 'theme_state.freezed.dart';
part 'theme_state.g.dart';


@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeState build() {
    String theme = SpUtils.getString(SpConstant.theme);
    if (theme.isEmpty || theme.toLowerCase() == "system") {
      return ThemeState(themeMode: ThemeMode.system);
    } else if (theme.toLowerCase() == "light") {
      return ThemeState(themeMode: ThemeMode.light);
    } else {
      return ThemeState(themeMode: ThemeMode.dark);
    }
  }

  void switchTheme(ThemeMode themeMode) {
    state = ThemeState(
      themeMode: themeMode,
    );
  }
}

Color getColor(WidgetRef ref, Color lightColor, Color darkColor) {
  final themeState = ref.read(themeNotifierProvider);
  if (themeState.themeMode == ThemeMode.system) {
    final Brightness brightness = MediaQuery
        .of(ref.context)
        .platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? darkColor : lightColor;
  }
  return themeState.themeMode == ThemeMode.light ? lightColor : darkColor;
}

String getImage(WidgetRef ref, String lightIcon, String darkIcon) {
  final themeState = ref.read(themeNotifierProvider);
  if (themeState.themeMode == ThemeMode.system) {
    final Brightness brightness = MediaQuery
        .of(ref.context)
        .platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return isDarkMode ? darkIcon : lightIcon;
  }
  return themeState.themeMode == ThemeMode.light ? lightIcon : darkIcon;
}

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required ThemeMode themeMode,
  }) = _ThemeState;
}