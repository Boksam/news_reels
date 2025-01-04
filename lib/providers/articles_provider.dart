import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reels/models/article.dart';
import 'package:news_reels/repositories/article_repository.dart';

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  return ArticleRepository(null);
});

final articlesProvider =
    FutureProvider.autoDispose<List<Article>?>((ref) async {
  final repository = ref.watch(articleRepositoryProvider);

  final DateTime today = DateTime.now();
  try {
    await repository.deleteOldArticles(today);
  } catch (e) {
    debugPrint("Failed to delete old articles: $e");
  }

  try {
    await repository.fetchAndStoreArticlesByDate(today);
  } catch (e) {
    debugPrint("Failed to fetch new articles: $e");
  }

  return repository.getArticlesByDate(today);
});
