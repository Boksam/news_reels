import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reels/models/article.dart';
import 'package:news_reels/repositories/article_repository.dart';

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  return ArticleRepository(null);
});

final articlesProvider =
    FutureProvider.autoDispose<List<Article>?>((ref) async {
  final repository = ref.watch(articleRepositoryProvider);

  repository.deleteArticles();

  repository.fetchAndStoreArticles();

  return repository.getArticles();
});
