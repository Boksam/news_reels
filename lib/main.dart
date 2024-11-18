import 'package:flutter/material.dart';
import 'package:news_reels/core/constants/dummy_article.dart';
import 'package:news_reels/features/news/presentation/screens/news_screen.dart';
import 'package:news_reels/features/news/presentation/widgets/news_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NewsScreen());
  }
}
