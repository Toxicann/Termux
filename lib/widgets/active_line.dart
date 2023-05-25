
import 'package:flutter/material.dart';

import 'hostname.dart';

class ActiveLine extends StatelessWidget {
  const ActiveLine({
    super.key,
    required TextEditingController textFieldController,
  }) : _textFieldController = textFieldController;

  final TextEditingController _textFieldController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const HostName(),
        Expanded(
          child: TextField(
            controller: _textFieldController,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ),
      ],
    );
  }
}