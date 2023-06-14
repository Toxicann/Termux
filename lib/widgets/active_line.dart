import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controller/termux.controller.dart';

import 'hostname.dart';
import 'inactive_line.dart';

class ActiveLine extends ConsumerWidget {
  const ActiveLine({
    super.key,
    required TextEditingController textFieldController,
    required this.focusNode,
  }) : _textFieldController = textFieldController;

  final TextEditingController _textFieldController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const HostName(),
        Expanded(
          child: TextField(
            onTapOutside: (event) => {},
            controller: _textFieldController,
            autofocus: true,
            focusNode: focusNode,
            style: Theme.of(context).textTheme.bodyMedium,
            onEditingComplete: () {
              var command = _textFieldController.text.trim();
              ref.read(termuxProvider).addHistory(
                    InactiveLine(lastCommand: command),
                  );
              if (command.isNotEmpty) {
                ref.read(termuxProvider).exec(command);
              }
              _textFieldController.clear();
            },
          ),
        ),
      ],
    );
  }
}
