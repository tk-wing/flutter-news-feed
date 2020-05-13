import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/load_status.dart';
import 'package:flutter_news_feed/data/search_type.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';
import 'package:flutter_news_feed/view/components/head_line_item.dart';
import 'package:flutter_news_feed/view/components/page_transformer.dart';
import 'package:flutter_news_feed/view/screens/news_web_page_screen.dart';
import 'package:flutter_news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);

    if (viewModel.loadStatus != LoadStatus.LOADING && viewModel.article.isEmpty) {
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            tooltip: '更新',
            onPressed: () => onRefresh(context),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<HeadLineViewModel>(
              builder: (context, model, child) {
                if (model.loadStatus == LoadStatus.LOADING) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return PageTransformer(
                  pageViewBuilder: (context, resolver) {
                    return PageView.builder(
                      controller: PageController(
                        viewportFraction: 0.85,
                      ),
                      itemCount: viewModel.article.length,
                      itemBuilder: (context, i) {
                        final article = model.article[i];
                        final visibility = resolver.resolvePageVisibility(i);
                        final fraction = visibility.visibleFraction;
                        return HeadLineItem(
                          article: article,
                          visibility: visibility,
                          onArticleClicked: (article) =>
                              _openArticleWebPage(article, context),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )),
    );
  }

  onRefresh(BuildContext context) async {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }

  _openArticleWebPage(Article article, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => new NewsWebPageScreen(article: article),
    ));
  }
}
