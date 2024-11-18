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
    return SwipeDetector(
      onSwipeLeft: () => _navigateToDetail(context),
      child: BlurredBackground(
        imageUrl: article.thumbnail ?? '',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.darken),
              child: Image.network(article.thumbnail ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    article.headline ?? 'Empty headline',
                    style: NewsTextStyles.headline.copyWith(fontSize: 20),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    height: 32,
                  ),
                  Text(
                    article.oneLineSummary ?? 'Empty one line summary',
                    style: NewsTextStyles.body,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
