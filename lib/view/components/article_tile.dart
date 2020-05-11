import 'package:flutter/material.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';
import 'package:flutter_news_feed/view/components/image_from_url.dart';
import 'package:flutter_news_feed/view/style/style.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  final ValueChanged<Article> onArticleClicked;
  const ArticleTile({this.article, this.onArticleClicked});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => onArticleClicked(article),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageFromUrl(imageUrl: article.urlToImage),
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        article.title,
                        style: textTheme.subhead.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        article.publishDate,
                        style: textTheme.overline
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 2.0),
                      Text(article.description ?? '', style: textTheme.body1.copyWith(
                        fontFamily: RegularFont
                      ),),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
