import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reels/core/service/article_sync_service.dart';
import 'package:news_reels/features/news/presentation/screens/news_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final today = DateTime.now();
  final ArticleSyncService articleSyncService = ArticleSyncService(null);
  await articleSyncService.syncArticle(today);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NewsScreen());
  }
}
