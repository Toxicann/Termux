import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/shared/colors.dart';
import 'package:portfolio/shared/storage_service.dart';

import 'termux.controller.dart';

final themeProd = ProviderContainer();

final themeProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends ChangeNotifier {
  late final Map<String, dynamic> _jsonData;

  late KColor themeColor;

  init() async {
    await _readJson();

    try {
      String? theme = StorageService.getUserTheme;
      if (theme == null) throw 'User Theme Not Found';
      themeColor = KColor.fromJson(_jsonData[theme]);
    } catch (e) {
      log('$e setting theme to dark');
      themeColor = KColor.fromJson(_jsonData["dark"]);
    }
    notifyListeners();
  }

  _readJson() async {
    final response = await rootBundle.loadString('json/theme.json');
    _jsonData = await json.decode(response);
  }

  changeTheme(Themes theme) {
    themeColor = KColor.fromJson(_jsonData[theme.name]);
    StorageService.setUserTheme(theme.name);

    notifyListeners();
  }
}
