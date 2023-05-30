import 'package:flutter/material.dart';

class RichifyTextResp extends StatelessWidget {
  RichifyTextResp({super.key, required this.response});
  List response;

  @override
  Widget build(BuildContext context) {
    styleText({required String text, dynamic style}) {
      List<TextSpan> formattedTextList = [];

      if (style == null) {
        formattedTextList.add(TextSpan(text: text));

        return formattedTextList;
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

      return formattedTextList;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: response.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 2.0,
        ),
        itemBuilder: (context, index) {
          List keys = response[index].keys.toList();
          dynamic displayText = styleText(
            text: response[index][keys[0]],
            style: keys.length > 1 ? response[index][keys[1]] : null,
          );

          return RichText(
            text: TextSpan(
              children: displayText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        },
      ),
    );
  }
}
