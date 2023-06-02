import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/shared/colors.dart';

import 'termux.controller.dart';

final themeProd = ProviderContainer();

final themeProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends ChangeNotifier {
  late final Map<String, dynamic> _jsonData;

  KColor? themeColor;

  init() async {
    await _readJson();
    themeColor = KColor.fromJson(_jsonData["dark"]);
    notifyListeners();
  }

  _readJson() async {
    final response = await rootBundle.loadString('json/theme.json');
    _jsonData = await json.decode(response);
  }

  changeTheme(Themes theme) {
    switch (theme) {
      case Themes.dark:
        themeColor = KColor.fromJson(_jsonData[theme.name]);

        break;
      case Themes.light:
        themeColor = KColor.fromJson(_jsonData[theme.name]);

        break;
      default:
    }
    notifyListeners();
  }
}
