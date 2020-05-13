import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/category_info..dart';
import 'package:flutter_news_feed/data/load_status.dart';
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

  List<Article> _articles = List();
  List<Article> get article => _articles;

  LoadStatus _loadStatus = LoadStatus.DONE;
  LoadStatus get loadStatus => _loadStatus;

  Future<void> getNews({
    @required SearchType searchType,
    String keyword,
    Category category,
  }) async {
    _searchType = searchType;
    _keyword = keyword;
    _category = category;

    await _newsRepository.getNews(
      searchType: _searchType,
      keyword: _keyword,
      category: _category,
    );
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
