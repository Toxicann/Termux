import 'package:flutter/material.dart';

class KColor {
  KColor({
    required this.backgroundColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });
  late final String backgroundColor;
  late final String primaryColor;
  late final String secondaryColor;
  late final String accentColor;

  factory KColor.fromJson(Map<String, dynamic> json) {
    return KColor(
      backgroundColor: json['backgroundColor'] ?? '#ffffff',
      primaryColor: json['primaryColor'] ?? '#000000',
      secondaryColor: json['secondaryColor'] ?? '#abcdef',
      accentColor: json['accentColor'] ?? '#123456',
    );
  }
}

extension HexColor on String {
  Color toColor() {
    final hexCode = replaceAll('#', '');
    return Color(int.parse('0xFF$hexCode'));
  }
}
