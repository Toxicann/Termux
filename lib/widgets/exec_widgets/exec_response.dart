import 'package:flutter/material.dart';

class ExecResponse extends StatelessWidget {
  ExecResponse({super.key, required this.response});

  List<String> response;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListView.builder(
        itemCount: response.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Text(
          response[index],
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
