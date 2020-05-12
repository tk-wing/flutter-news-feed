import 'package:flutter_news_feed/models/database/database.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';

//モデルクラス => DBのテーブルクラス
extension ConvertToArticleRecord on List<Article> {
  List<ArticleRecord> toArticleRecords(List<Article> articles) {
    var articleRecords = List<ArticleRecord>();
    articles.forEach((article) {
      articleRecords.add(ArticleRecord(
        title: article.title ?? '',
        description: article.description ?? '',
        url: article.url,
        urlToImage: article.urlToImage ?? '',
        publishedAt: article.publishDate ?? '',
        content: article.content ?? '',
      ));
    });

    return articleRecords;
  }
}

//DBのテーブルクラス => モデルクラス
extension ConvertToArticle on List<ArticleRecord> {
  List<Article> toArticleRecords(List<ArticleRecord> articleRecoreds) {
    var  articles = List<Article>();
    articleRecoreds.forEach((articleRecored) {
      articles.add(Article(
        title: articleRecored.title,
        description: articleRecored.description,
        url: articleRecored.url,
        urlToImage: articleRecored.urlToImage,
        publishDate: articleRecored.publishedAt,
        content: articleRecored.content,
      ));
    });

    return articles;
  }
}
