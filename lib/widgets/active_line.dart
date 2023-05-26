import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controller/termux.controller.dart';

import 'hostname.dart';
import 'inactive_line.dart';

class ActiveLine extends ConsumerWidget {
  const ActiveLine({
    super.key,
    required TextEditingController textFieldController,
  }) : _textFieldController = textFieldController;

  final TextEditingController _textFieldController;

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
            style: Theme.of(context).textTheme.bodyMedium,
            onEditingComplete: () {
              ref.read(termuxProvider).addHistory(
                    InactiveLine(lastCommand: _textFieldController.text),
                  );
              if (_textFieldController.text.isNotEmpty) {
                ref.read(termuxProvider).exec(_textFieldController.text);
              }
              _textFieldController.clear();
            },
          ),
        ),
      ],
    );
  }
}
