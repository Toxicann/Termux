import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/exec_widgets/exec_response.dart';
import '../widgets/exec_widgets/richify_text_response.dart';
import '../widgets/exec_widgets/tabular_response.dart';
import '../widgets/hero_text.dart';

final termuxProvider =
    ChangeNotifierProvider.autoDispose<TermuxNotifier>((ref) {
  return TermuxNotifier();
});

enum Commands { clear, help, about, welcome, socials }

class TermuxNotifier extends ChangeNotifier {
  final List<Widget> _commandHistory = [];
  final List<Widget> _activeWidget = [];
  late final _jsonData;

  List<Widget> get commandHistory => [..._commandHistory, ..._activeWidget];
  List<Map<String, dynamic>> get jsonData => _jsonData;

  initWidget(Widget widget) async {
    await readJson();
    runCommand(Commands.welcome);
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
      // List commandList = command.trim().split(" ");
      // if(commandList.length > 1)
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
      case Commands.about:
        _commandHistory.add(
          RichifyTextResp(
            response: _jsonData['exec_resp']["about"],
          ),
        );
        break;
      case Commands.welcome:
        _commandHistory.add(HeroText());
        _commandHistory.add(
          RichifyTextResp(
            response: _jsonData['exec_resp']["welcome"],
          ),
        );
        break;
      case Commands.socials:
        _commandHistory.add(
          TabularResponse(
            response: _jsonData['exec_resp']["socials"],
          ),
        );
        break;

      default:
    }
  }
}
