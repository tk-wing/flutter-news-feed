import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/search_type.dart';
import 'package:flutter_news_feed/viewmodels/head_line_viewmodel.dart';
import 'package:provider/provider.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);

    if(!viewModel.isLoading && viewModel.article.isEmpty){
      Future(() => viewModel.getHeadLines(searchType: SearchType.HEAD_LINE));
    }
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: '更新',
          onPressed: () => onRefresh(context),
        ),
        body: Center(
          child: Container(
            child: Text('ヘッドラインページ'),
          ),
        ),
      ),
    );
  }

  //TODO
  onRefresh(BuildContext context) async{
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getHeadLines(searchType: SearchType.HEAD_LINE);
  }
}
