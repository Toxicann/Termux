import 'package:flutter/material.dart';

class RichifyTextResp extends StatelessWidget {
  RichifyTextResp({super.key, required this.response});
  List response;
  List<TextSpan> formattedTextList = [];

  @override
  Widget build(BuildContext context) {
    styleText({required String text, dynamic style}) {
      formattedTextList.clear();

      if (style == null) {
        formattedTextList.add(TextSpan(text: text));
        return;
      }

      style as List;

      List<String> splittedText = text.trim().split(" ");
      for (var element in splittedText) {
        if (style.contains(element)) {
          formattedTextList.add(
            TextSpan(
              text: element,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).highlightColor,
                  ),
            ),
          );
        } else {
          formattedTextList.add(TextSpan(text: element));
        }

        if (splittedText.last != element) {
          formattedTextList.add(const TextSpan(text: " "));
        }
      }
      return;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: response.length,
        itemBuilder: (context, index) {
          List keys = response[index].keys.toList();
          styleText(
            text: response[index][keys[0]],
            style: keys.length > 1 ? response[index][keys[1]] : null,
          );

          return RichText(
            text: TextSpan(
              children: formattedTextList,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        },
      ),
    );
  }
}
