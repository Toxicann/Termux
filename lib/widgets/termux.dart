import 'package:flutter/material.dart';

import 'active_line.dart';

class Termux extends StatelessWidget {
  Termux({super.key});

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          ActiveLine(textFieldController: _textFieldController),
        ],
      ),
    );
  }
}