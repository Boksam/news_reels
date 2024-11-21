import 'package:flutter/material.dart';
import 'package:news_reels/data/models/article.dart';
import 'package:news_reels/features/news/presentation/screens/news_detail_screen.dart';
import 'package:news_reels/features/news/presentation/styles/text_styles.dart';
import 'package:news_reels/features/news/presentation/widgets/blurred_background_image.dart';
import 'package:news_reels/features/news/presentation/widgets/swipe_detector.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({Key? key, required this.article}) : super(key: key);

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SwipeDetector(
      onSwipeLeft: () => _navigateToDetail(context),
      child: Stack(
        children: [
          SizedBox(
            height: screenHeight,
            child: Image.network(
              article.thumbnail ?? '',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.9)
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    if (article.section?.isNotEmpty == true)
                      _buildTag(article.section),
                    if (article.type?.isNotEmpty == true)
                      _buildTag(article.type),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  article.headline ?? 'Empty headline',
                  style: NewsTextStyles.headline,
                ),
                Divider(
                  color: Colors.white.withOpacity(0.7),
                  thickness: 0.5,
                  height: 32,
                ),
                Text(
                  article.oneLineSummary ?? 'Empty one line summary',
                  style: NewsTextStyles.body,
                ),
                SizedBox(height: screenHeight * 0.08),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(tagName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        tagName ?? '',
        style: NewsTextStyles.tag,
      ),
    );
  }
}
