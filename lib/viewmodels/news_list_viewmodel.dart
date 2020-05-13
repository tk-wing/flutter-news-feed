import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/category_info..dart';
import 'package:flutter_news_feed/data/search_type.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';
import 'package:flutter_news_feed/models/repositories/news_repository.dart';
import 'package:provider/provider.dart';

class NewsListViewModel extends ChangeNotifier {
  final NewsRepository _newsRepository;

  NewsListViewModel({newsRepository}) : _newsRepository = newsRepository;

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = '';
  String get keyword => _keyword;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Article> _articles = List();
  List<Article> get article => _articles;

  Future<void> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    _searchType = searchType;
    _keyword = keyword;
    _category = category;

    _isLoading = true;
    notifyListeners();

    _articles = await _newsRepository.getNews(
      searchType: _searchType,
      keyword: _keyword,
      category: _category,
    );

    print(_articles[0]);

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _newsRepository.dispose();
    super.dispose();
  }
}
