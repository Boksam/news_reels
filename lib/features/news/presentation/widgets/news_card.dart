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
    final screenWidth = MediaQuery.of(context).size.width;

    return SwipeDetector(
      onSwipeLeft: () => _navigateToDetail(context),
      child: BlurredBackground(
        imageUrl: article.thumbnail ?? '',
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.5,
                  maxWidth: screenWidth,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    article.thumbnail ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
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
                    color: Colors.white.withOpacity(0.5),
                    thickness: 0.5,
                    height: 32,
                  ),
                  Text(
                    article.oneLineSummary ?? 'Empty one line summary',
                    style: NewsTextStyles.body,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildTag(tagName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Text(
        tagName ?? '',
        style: NewsTextStyles.tag,
      ),
    );
  }
}
