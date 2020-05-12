import 'package:flutter_news_feed/models/database/database.dart';
import 'package:flutter_news_feed/models/model/news_model.dart';
import 'package:moor/moor.dart';

part 'dao.g.dart';

@UseDao(tables: [ArticleRecords])
class NewsDao extends DatabaseAccessor<MyDataBase> with _$NewsDaoMixin {
  NewsDao(MyDataBase db) : super(db);

  Future clear() => delete(articleRecords).go();

  Future insert(List<ArticleRecord> articles) async {
    await batch((batch) {
      batch.insertAll(articleRecords, articles);
    });
  }

  Future<List<ArticleRecord>> get getArticles => select(articleRecords).get();

  Future<List<ArticleRecord>> replace(List<ArticleRecord> articles) =>
      transaction(() async {
        await clear();
        await insert(articles);
        return await getArticles;
      });
}
