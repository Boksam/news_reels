// lib/features/news/presentation/screens/news_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reels/features/news/presentation/widgets/news_card.dart';
import 'package:news_reels/features/news/providers/articles_provider.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends ConsumerState<NewsScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final articlesAsyncValue = ref.watch(articlesProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(articlesProvider.future),
        child: articlesAsyncValue.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load articles'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => ref.refresh(articlesProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (articles) {
            if (articles == null || articles.isEmpty) {
              return const Center(
                child: Text('No articles available'),
              );
            }

            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return NewsCard(
                  article: articles[index],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
