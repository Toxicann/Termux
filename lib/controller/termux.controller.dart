import 'dart:convert';
import 'dart:developer';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/string.dart';
import '../widgets/exec_widgets/exec_response.dart';
import '../widgets/exec_widgets/richify_text_response.dart';
import '../widgets/exec_widgets/tabular_response.dart';
import '../widgets/hero_text.dart';

final termuxProvider =
    ChangeNotifierProvider.autoDispose<TermuxNotifier>((ref) {
  return TermuxNotifier();
});

enum Commands {
  clear,
  help,
  about,
  welcome,
  socials,
}

enum Flags {
  go,
  help,
}

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
      List commandList = command.trim().split(" ");
      if (commandList.length == 1) {
        Commands enumCommand =
            EnumToString.fromString(Commands.values, command)!;
        runCommand(enumCommand);
        return;
      }
      Commands enumCommand =
          EnumToString.fromString(Commands.values, commandList[0])!;

      if (!isFlag(commandList[1])) throw "unidentified flag";

      runCommand(enumCommand, flag: commandList[1]);
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

  runCommand(Commands command, {String? flag}) {
    Flags? flagCommand;
    if (flag != null) {
      try {
        flag = flag.replaceAll('--', '');
        flagCommand = EnumToString.fromString(Flags.values, flag)!;
      } catch (e) {
        _commandHistory.add(
          ExecResponse(
            response: [
              "Command Not Found: ${command.name} --$flag",
              "",
              ..._jsonData['usage'][command.name]
            ],
          ),
        );
        return;
      }
    }

    _disallowFlag(Commands command, Flags? flag) {
      if (flag != null) throw command.name;
    }

    _allowFlags(List<Flags> flagList, Flags? flag, Commands command) {
      if (!flagList.contains(flag)) {
        throw command.name;
      }
    }

    try {
      switch (command) {
        case Commands.clear:
          _disallowFlag(command, flagCommand);
          _commandHistory.clear();
          break;
        case Commands.help:
          _disallowFlag(command, flagCommand);
          _commandHistory.add(
            TabularResponse(
              response: _jsonData['exec_resp']["help"],
            ),
          );
          break;
        case Commands.about:
          _disallowFlag(command, flagCommand);
          _commandHistory.add(
            RichifyTextResp(
              response: _jsonData['exec_resp']["about"],
            ),
          );
          break;
        case Commands.welcome:
          _disallowFlag(command, flagCommand);
          _commandHistory.add(const HeroText());
          _commandHistory.add(
            RichifyTextResp(
              response: _jsonData['exec_resp']["welcome"],
            ),
          );
          break;
        case Commands.socials:
          _allowFlags([Flags.go], flagCommand, command);
          if (flagCommand == null) {
            _commandHistory.add(
              TabularResponse(
                response: _jsonData['exec_resp']["socials"],
              ),
            );
            _commandHistory.add(
              ExecResponse(response: _jsonData['usage']["socials"]),
            );
          }
          break;

        default:
      }
    } catch (e) {
      inspect(e);
      _commandHistory.add(
        ExecResponse(
          response: [
            "Command Not Found: ${command.name} --$flag",
            "",
            ..._jsonData['usage'][e]
          ],
        ),
      );
    }
  }
}
