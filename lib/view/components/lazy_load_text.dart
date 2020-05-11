import 'package:flutter/material.dart';
import 'package:flutter_news_feed/view/components/page_transformer.dart';

class LazyLoadText extends StatelessWidget {
  final String text;
  final PageVisibility visibility;

  LazyLoadText({@required this.text, @required this.visibility});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Opacity(
      opacity: visibility.visibleFraction,
      child: Transform(
        alignment: Alignment.topLeft,
        transform: Matrix4.translationValues(
          visibility.pagePosition * 200,
          0.0,
          0.0,
        ),
        child: Text(
          text,
          style: textTheme.title.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
