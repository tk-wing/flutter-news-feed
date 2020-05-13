import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/category_info..dart';
import 'package:flutter_news_feed/data/load_status.dart';
import 'package:flutter_news_feed/data/search_type.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';
import 'package:flutter_news_feed/models/repositories/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  final NewsRepository _newsRepository;

  HeadLineViewModel({newsRepository}) : _newsRepository = newsRepository;

  SearchType _searchType = SearchType.HEAD_LINE;
  SearchType get searchType => _searchType;

  List<Article> _articles = List();
  List<Article> get article => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  Future<void> getHeadLines({@required SearchType searchType}) async {
    _searchType = searchType;
    await _newsRepository.getNews(searchType: _searchType);
  }

  @override
  void dispose() {
    _newsRepository.dispose();
    super.dispose();
  }

  void onRepositoryUpdate(NewsRepository repository) {
    _articles = repository.articles;
    _loadStatus = repository.loadStatus;
    notifyListeners();
  }
}
