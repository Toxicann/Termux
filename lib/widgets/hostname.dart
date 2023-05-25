import 'package:flutter/material.dart';

class HostName extends StatelessWidget {
  const HostName({
    super.key,
  });

  final String name = "root";
  final String host = "Desktop";

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
          children: [
            TextSpan(
              text: "@",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            TextSpan(
              text: "$host:",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).highlightColor,
                  ),
            ),
            TextSpan(
              text: "\$ ~ ",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ]),
    );
  }
}
