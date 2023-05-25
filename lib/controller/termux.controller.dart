import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final termuxProvider =
    ChangeNotifierProvider.autoDispose<TermuxNotifier>((ref) {
  return TermuxNotifier();
});

class TermuxNotifier extends ChangeNotifier {
  final List<Widget> _commandHistory = [];
  final List<Widget> _activeWidget = [];

  List<Widget> get commandHistory => [..._commandHistory, ..._activeWidget];

  initWidget(Widget widget) {
    _activeWidget.add(
      widget,
    );
    notifyListeners();
  }

  addHistory(Widget widget) {
    _commandHistory.add(
      widget,
    );
    notifyListeners();
  }
}
