import 'package:flutter/material.dart';

import 'hostname.dart';

class InactiveLine extends StatelessWidget {
  const InactiveLine({
    super.key,
    required String lastCommand,
  }) : _lastCommand = lastCommand;

  final String _lastCommand;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const HostName(),
        Expanded(
          child: Text(
            _lastCommand,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
