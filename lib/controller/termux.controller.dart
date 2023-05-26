import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/widgets/exec_response.dart';

final termuxProvider =
    ChangeNotifierProvider.autoDispose<TermuxNotifier>((ref) {
  return TermuxNotifier();
});

enum Commands { clear, help }

class TermuxNotifier extends ChangeNotifier {
  final List<Widget> _commandHistory = [];
  final List<Widget> _activeWidget = [];
  late final _jsonData;

  List<Widget> get commandHistory => [..._commandHistory, ..._activeWidget];
  List<Map<String, dynamic>> get jsonData => _jsonData;

  initWidget(Widget widget) {
    readJson();
    _activeWidget.add(
      widget,
    );
    notifyListeners();
  }

  readJson() async {
    final String response = await rootBundle.loadString('config.json');
    _jsonData = await json.decode(response);
  }

  addHistory(Widget widget) {
    _commandHistory.add(
      widget,
    );
    notifyListeners();
  }

  exec(String command) {
    try {
      var enumCommand = EnumToString.fromString(Commands.values, command);
      runCommand(enumCommand!);
    } catch (e) {
      _commandHistory.add(
        ExecResponse(
          response: [
            "Command Not Found: $command",
            "Type \"help\" to get a list of commands"
          ],
        ),
      );
    } finally {
      notifyListeners();
    }
  }

  runCommand(Commands command) {
    switch (command) {
      case Commands.clear:
        _commandHistory.clear();
        break;
      case Commands.help:
        _commandHistory.add(
          TabularResponse(
            response: _jsonData['exec_resp']["help"],
          ),
        );
        break;

      default:
    }
  }
}
