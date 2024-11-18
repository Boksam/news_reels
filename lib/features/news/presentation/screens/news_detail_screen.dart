// news_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:news_reels/data/models/article.dart';
import 'package:news_reels/features/news/presentation/styles/text_styles.dart';
import 'package:news_reels/features/news/presentation/widgets/blurred_background_image.dart';
import 'package:news_reels/features/news/presentation/widgets/swipe_detector.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => Navigator.pop(context),
      child: BlurredBackground(
        imageUrl: article.thumbnail ?? '',
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    article.headline ?? 'Empty headline',
                    style: NewsTextStyles.headline,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    height: 32,
                  ),
                  Text(
                    article.content ?? 'Empty full summary',
                    style: NewsTextStyles.detailBody,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
