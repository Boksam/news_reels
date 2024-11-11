import 'package:flutter/material.dart';
import 'package:news_reels/data/models/article.dart';
import 'package:news_reels/features/news/presentation/widgets/blurred_background_image.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback onSwipeRight;

  const NewsCard({Key? key, required this.article, required this.onSwipeRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          onSwipeRight();
        }
      },
      child: BlurredBackgroundImage(
          imageUrl: article.thumbnail ?? '',
          child: Positioned(
              top: MediaQuery.of(context).size.height * 0.66,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      article.headline ?? 'Empty headline',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 32,
                    ),
                    Text(
                      article.oneLineSummary ?? 'Empty one line summary',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 16)
                  ],
                ),
              ))),
    );
  }
}
