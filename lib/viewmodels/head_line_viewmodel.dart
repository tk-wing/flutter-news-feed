import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/category_info..dart';
import 'package:flutter_news_feed/data/search_type.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';
import 'package:flutter_news_feed/models/repositories/news_repository.dart';

class HeadLineViewModel extends ChangeNotifier {
  final NewsRepository _newsRepository;

  HeadLineViewModel({newsRepository}) : _newsRepository = newsRepository;

  SearchType _searchType = SearchType.HEAD_LINE;
  SearchType get searchType => _searchType;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Article> _articles = List();
  List<Article> get article => _articles;

  Future<void> getHeadLines({@required SearchType searchType}) async {
    _searchType = searchType;
    _isLoading = true;
    notifyListeners();
    _articles = await _newsRepository.getNews(searchType: _searchType);

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _newsRepository.dispose();
    super.dispose();
  }
}
