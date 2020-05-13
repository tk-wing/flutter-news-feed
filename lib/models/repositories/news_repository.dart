import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/category_info..dart';
import 'package:flutter_news_feed/data/load_status.dart';
import 'package:flutter_news_feed/data/search_type.dart';
import 'package:flutter_news_feed/models/database/dao.dart';
import 'package:flutter_news_feed/models/database/database.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';
import 'package:flutter_news_feed/models/networking/api_service.dart';
import 'package:provider/provider.dart';

class NewsRepository extends ChangeNotifier {
  final ApiService _apiService;
  final NewsDao _dao;

  NewsRepository({dao, apiService})
      : _apiService = apiService,
        _dao = dao;

  List<Article> _articles = List();
  List<Article> get articles => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  Future<void> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    _loadStatus = LoadStatus.LOADING;
    notifyListeners();

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
        await _store(responseBody);
        _loadStatus = LoadStatus.DONE;
      } else {
        final errorCode = response.statusCode;
        final error = response.error;
        _loadStatus = LoadStatus.RESPONSE_ERROR;
        print("Request is not successful: ${errorCode} / ${error}");
      }
    } on Exception catch (error) {
      _loadStatus = LoadStatus.NETWORK_ERROR;
      print("error: ${error}");
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  Future _store(responseBody) async {
    final articlesFromNetwork = News.fromJson(responseBody).articles;

    //webから取得した記事リストをDBをのテーブルクラスに変換してDB登録・取得
    final articlesFromDB =
        await _dao.replace(_toArticleRecord(articlesFromNetwork));

    //DBから取得したデータをモデルクラスに再変換
    _articles = _toArticle(articlesFromDB);
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
