import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/category_info..dart';
import 'package:flutter_news_feed/data/search_type.dart';
import 'package:flutter_news_feed/main.dart';
import 'package:flutter_news_feed/models/database/dao.dart';
import 'package:flutter_news_feed/models/database/database.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';
import 'package:flutter_news_feed/models/networking/api_service.dart';
import 'package:provider/provider.dart';

class NewsRepository {
  final ApiService _apiService;
  final NewsDao _dao;

  NewsRepository({dao, apiService})
      : _apiService = apiService,
        _dao = dao;

  Future<List<Article>> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    List<Article> result;
    Response response;

    try {
      switch (searchType) {
        case SearchType.HEAD_LINE:
          response = await _apiService.getHeadLines();
          break;
        case SearchType.KEYWORD:
          response = await _apiService.getKeywordNews(keyword: keyword);
          break;
        case SearchType.CATEGORY:
          response =
              await _apiService.getCategoryNews(category: category.nameEn);
          break;
      }

      if (response.isSuccessful) {
        final responseBody = response.body;
        result = await _store(responseBody);
      } else {
        final errorCode = response.statusCode;
        final error = response.error;
        print("Request is not successful: ${errorCode} / ${error}");
      }
    } on Exception catch (error) {
      print("error: ${error}");
    }

    return result;
  }

  void dispose() {
    _apiService.dispose();
  }

  Future<List<Article>> _store(responseBody) async {
    final articles = News.fromJson(responseBody).articles;

    //webから取得した記事リストをDBをのテーブルクラスに変換してDB登録・取得
    final articleRecords = await _dao.replace(_toArticleRecord(articles));

    //DBから取得したデータをモデルクラスに再変換して返す
    return _toArticle(articleRecords);
  }

  List<ArticleRecord> _toArticleRecord(List<Article> articles) {
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

  List<Article> _toArticle(List<ArticleRecord> articleRecoreds) {
    var articles = List<Article>();
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
