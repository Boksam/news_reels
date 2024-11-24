import 'package:news_reels/data/repositories/article_repository.dart';

class ArticleSyncService {
  final ArticleRepository _articleRepository;

  ArticleSyncService(ArticleRepository? articleRepository)
      : _articleRepository = articleRepository ?? ArticleRepository(null);

  Future<void> syncArticle(DateTime? date) async {
    final DateTime today = date ?? DateTime.now();
    await _articleRepository.deleteOldArticles(today);
    await _articleRepository.fetchAndStoreArticlesByDate(today);
  }
}
