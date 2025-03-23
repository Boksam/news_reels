// news_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:news_reels/models/article.dart';
import 'package:news_reels/presentation/styles/text_styles.dart';
import 'package:news_reels/presentation/widgets/blurred_background_image.dart';
import 'package:news_reels/presentation/widgets/swipe_detector.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => Navigator.pop(context),
      child: BlurredBackground(
        imageUrl: article.thumbnail ?? '',
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Markdown(
                data: article.summaryMd ?? 'Empty summary',
                styleSheet: NewsTextStyles.markdown,
              )),
        ),
      ),
    );
  }
}
