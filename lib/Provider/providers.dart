import 'package:flutter_news_feed/models/database/dao.dart';
import 'package:flutter_news_feed/models/database/database.dart';
import 'package:flutter_news_feed/models/networking/api_service.dart';
import 'package:flutter_news_feed/models/repositories/news_repository.dart';
import 'package:flutter_news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:flutter_news_feed/viewmodels/news_list_viewmodel.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...vireModels,
];

List<SingleChildWidget> independentModels = [
  Provider<ApiService>(
    create: (_) => ApiService.create(),
    dispose: (_, apiService) => apiService.dispose(),
  ),
  Provider<MyDataBase>(
    create: (_) => MyDataBase(),
    dispose: (_, db) => db.close(),
  )
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyDataBase, NewsDao>(
    update: (_, db, dao) => NewsDao(db),
  ),
  ChangeNotifierProvider<NewsRepository>(
    create: (context) => NewsRepository(
      dao: Provider.of<NewsDao>(context, listen: false),
      apiService: Provider.of<ApiService>(context, listen: false),
    ),
  )
];

List<SingleChildWidget> vireModels = [
  ChangeNotifierProxyProvider<NewsRepository ,HeadLineViewModel>(
    create: (context) => HeadLineViewModel(
      newsRepository: Provider.of<NewsRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) => viewModel..onRepositoryUpdate(repository),
  ),
  ChangeNotifierProxyProvider<NewsRepository ,NewsListViewModel>(
    create: (context) => NewsListViewModel(
      newsRepository: Provider.of<NewsRepository>(context, listen: false),
    ),
    update: (context, repository, viewModel) => viewModel..onRepositoryUpdate(repository),
  )
];
