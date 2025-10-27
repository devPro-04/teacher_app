
import 'package:flutter/material.dart';
import 'package:olinom/widgets/see_more_less.dart';

class ExpandableWidget extends StatelessWidget {
  final String? content;

  ExpandableWidget({
    super.key,
    required this.content,
  });

  ValueNotifier<bool> expanded = ValueNotifier(false);
  final int maxLinesToShow = 4;

  @override
  Widget build(BuildContext context) {
    final TextSpan textSpan = TextSpan(
      text: content ?? "",
      style: const TextStyle(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        fontSize: 11.0,
        color: Colors.black,
      ),
    );

    final TextPainter textPainter = TextPainter(
      text: textSpan,
      maxLines: expanded.value ? null : maxLinesToShow,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final int numberOfLines = textPainter.computeLineMetrics().length;
    return ValueListenableBuilder(
      valueListenable: expanded,
      builder: (context, values, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (!expanded.value && numberOfLines >= maxLinesToShow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content ?? "",
                        maxLines: maxLinesToShow,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Color.fromRGBO(129, 137, 149, 1),
                          height: 2
                        ),
                      ),
                      /* See More :: type 1 - See More | 2 - See Less */
                      SeeMoreLessWidget(
                        textData: 'Voir plus',
                        type: 1,
                        onSeeMoreLessTap: () {
                          expanded.value = true;
                        },
                      ),
                      /* See More :: type 1 - See More | 2 - See Less */
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content ?? "",
                        style: const TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Color.fromRGBO(129, 137, 149, 1),
                          height: 2,
                        ),
                      ),
                      if (expanded.value && numberOfLines >= maxLinesToShow)
                        /* See Less :: type 1 - See More | 2 - See Less */
                        SeeMoreLessWidget(
                          textData: 'Voir moins',
                          type: 2,
                          onSeeMoreLessTap: () {
                            expanded.value = false;
                          },
                        ),
                      /* See Less :: type 1 - See More | 2 - See Less */
                    ],
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}