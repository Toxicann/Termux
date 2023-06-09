import 'dart:convert';
import 'dart:developer';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controller/theme.controller.dart';
import 'package:portfolio/shared/url_helper.dart';

import '../shared/string.dart';
import '../widgets/exec_widgets/exec_response.dart';
import '../widgets/exec_widgets/richify_text_response.dart';
import '../widgets/exec_widgets/tabular_response.dart';
import '../widgets/hero_text.dart';

// final themeProd = ProviderContainer();

final termuxProvider =
    ChangeNotifierProvider.autoDispose<TermuxNotifier>((ref) {
  return TermuxNotifier(themeContainer: themeProd);
});

enum Commands {
  clear,
  help,
  about,
  welcome,
  resume,
  socials,
  contact,
  theme,
}

enum Flags {
  go,
  help,
  set,
}

enum Themes { dark, matrix, ubuntu }

class TermuxNotifier extends ChangeNotifier {
  final List<Widget> _commandHistory = [];
  final List<Widget> _activeWidget = [];
  late final Map<String, dynamic> _jsonData;

  List<Widget> get commandHistory => [..._commandHistory, ..._activeWidget];
  Map<String, dynamic> get jsonData => _jsonData;

  final ProviderContainer themeContainer;

  TermuxNotifier({required this.themeContainer});

  initWidget(Widget widget) async {
    await readJson();
    runCommand(Commands.welcome);
    _activeWidget.add(
      widget,
    );
    notifyListeners();
  }

  readJson() async {
    final String response = await rootBundle.loadString('json/config.json');
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
        print(enumCommand);
        runCommand(enumCommand);
        return;
      }
      Commands enumCommand =
          EnumToString.fromString(Commands.values, commandList[0])!;

      if (!isFlag(commandList[1])) throw "unidentified flag";

      runCommand(enumCommand,
          flag: commandList[1],
          action: commandList.length > 2 ? commandList[2] : null);
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

  runCommand(Commands command, {String? flag, String? action}) {
    Flags? flagCommand;
    int? num;
    dynamic trigger;

    if (flag != null) {
      try {
        flag = flag.replaceAll('--', '');
        flagCommand = EnumToString.fromString(Flags.values, flag)!;
        if (action == null) throw 'null';

        if (command == Commands.socials) {
          num = int.parse(action);
        } else {
          trigger = action;
        }
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
      if (flag != null && !flagList.contains(flag)) {
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
        case Commands.resume:
          _disallowFlag(command, flagCommand);
          _commandHistory.add(
            ExecResponse(
              response: const [
                "------LINK UNDER CONSTRUCTION-----------",
                "Opening a link to my CV! Please Wait ...",
              ],
            ),
          );
          UrlHelper.urlLauncher(_jsonData['exec_resp']["resume"],
              addHead: false);
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
        case Commands.contact:
          _disallowFlag(command, flagCommand);
          _commandHistory.add(
            RichifyTextResp(
              response: _jsonData['exec_resp']["contact"]["details"],
            ),
          );
          _commandHistory.add(
            TabularResponse(
              response: _jsonData['exec_resp']["contact"]["info"],
            ),
          );

          break;
        case Commands.theme:
          _allowFlags([Flags.set], flagCommand, command);
          final themeNotifier = themeContainer.read(themeProvider);

          if (flagCommand == null) {
            _commandHistory.add(
              RichifyTextResp(
                response: _jsonData['exec_resp']["theme"],
              ),
            );
            _commandHistory.add(
              ExecResponse(response: _jsonData['usage']["theme"]),
            );
          }

          switch (flagCommand) {
            case Flags.set:
              if (trigger == null) throw command.name;
              trigger = EnumToString.fromString(Themes.values, trigger);
              themeNotifier.changeTheme(trigger);
              break;
            default:
          }

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
          switch (flagCommand) {
            case Flags.go:
              if (num == null) throw command.name;

              if (num == 1) {
                UrlHelper.urlLauncher(
                    _jsonData['exec_resp']["socials"][num - 1]["function"]);
              } else if (num == 2) {
                UrlHelper.urlLauncher(
                    _jsonData['exec_resp']["socials"][num - 1]["function"]);
              } else if (num == 3) {
                UrlHelper.urlLauncher(
                    _jsonData['exec_resp']["socials"][num - 1]["function"]);
              } else {
                throw command.name;
              }
              break;
            default:
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
