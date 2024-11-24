import 'dart:convert';

import 'package:news_reels/core/config/api_config.dart';
import 'package:news_reels/core/service/api_service.dart';
import 'package:news_reels/data/models/article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ArticleRepository {
  final ApiService _apiService;
  static Database? _database;

  ArticleRepository(ApiService? apiService)
      : _apiService = apiService ?? ApiService();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    /// Initiates database.
    ///
    /// It will create essential tables like articles.
    /// This should be fixed if the model changes.
    return await openDatabase(
      join(await getDatabasesPath(), 'articles.db'),
      version: 1,
      onCreate: (db, version) async => {
        await db.execute('''
          CREATE TABLE articles(
            CREATE TABLE articles(
            id INTEGER PRIMARY KEY,
            headline TEXT,
            content TEXT,
            full_summary TEXT,
            one_line_summary TEXT,
            section TEXT,
            type TEXT,
            thumbnail TEXT,
            language TEXT,
            url TEXT,
            created_at TEXT,
            updated_at TEXT
          )
          ''')
      },
    );
  }

  Future<void> fetchAndStoreArticlesByDate(DateTime date) async {
    /// Fetches and Stores today's articles.
    String formattedDate = date.toIso8601String().split('T')[0];

    try {
      final response = await _apiService
          .get(ApiEndPoints.articles(date), {'date': formattedDate});

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = json.decode(response.body);
        final db = await database;

        await db.transaction((txn) async {
          txn.delete(
            'articles',
            where: 'DATE(created_at) = ?',
            whereArgs: [formattedDate],
          );

          for (var articleJson in articlesJson) {
            Article article = Article.fromJson(articleJson);
            txn.insert('articles', article.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }
        });
      } else {
        throw Exception(
            'Failed to fetch and store articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }

  Future<void> deleteOldArticles(DateTime date, {int period = 7}) async {
    final DateTime endDate = date.subtract(Duration(days: period));
    final String formattedEndDate = endDate.toIso8601String().split('T')[0];

    try {
      final db = await database;
      db.transaction((txn) async {
        txn.delete(
          'articles',
          where: 'DATE(created_at) < ?',
          whereArgs: [formattedEndDate],
        );
      });
    } catch (e) {
      throw Exception("Failed to delete old articles: $e");
    }
  }
}
