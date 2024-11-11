import 'package:flutter/material.dart';
import 'package:news_reels/data/models/article.dart';
import 'package:news_reels/features/articles/presentation/widgets/blurred_background_image.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => {if (details.delta.dx > 0) {}},
      child: BlurredBackgroundImage(
          imageUrl: article.thumbnail ?? '',
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  article.headline ?? 'Empty headline',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
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
          )),
    );
  }
}
