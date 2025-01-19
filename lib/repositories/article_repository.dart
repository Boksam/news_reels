import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_reels/config/api_config.dart';
import 'package:news_reels/service/api_service.dart';
import 'package:news_reels/models/article.dart';
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

  /// Initiates database.
  ///
  /// It will create essential tables like articles.
  /// This should be fixed if the model changes.
  Future<Database> initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'articles.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
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
        ''');
      },
    );
  }

  Future<void> deleteArticlesBeforeDate(DateTime date) async {
    final db = await database;
    final formattedDate = date.toIso8601String().split('T')[0];

    db.delete('articles',
        where: 'DATE(created_at) < ?', whereArgs: [formattedDate]);
  }

  Future<void> fetchAndStoreArticlesByDate(DateTime date) async {
    final String formattedDate = date.toIso8601String().split('T')[0];
    final response = await _apiService
        .get(ApiEndPoints.articles(date), {'date': formattedDate});

    if (response.statusCode != 200) {
      throw Exception('Request failed with status code ${response.statusCode}');
    }

    final List<dynamic> articlesJson = json.decode(response.body)['articles'];

    final List<Article> articles =
        articlesJson.map((json) => Article.fromJson(json)).toList();

    final db = await database;
    for (Article article in articles) {
      db.insert('articles', article.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    debugPrint('Added ${articles.length} articles');
  }

  Future<void> syncArticlesByDate(DateTime date) async {
    debugPrint('Start sync articles. date: $date');

    // Delete articles older than `date`.
    deleteArticlesBeforeDate(date);

    // Fetch articles created in `date`.
    fetchAndStoreArticlesByDate(date);
  }

  Future<List<Article>?> getArticlesByDate(DateTime date) async {
    final db = await database;
    final String formattedDate = date.toIso8601String().split('T')[0];

    final List<Map<String, dynamic>> articlesJson = await db.query('articles',
        where: 'DATE(created_at) = ?', whereArgs: [formattedDate]);

    final List<Article> articles =
        articlesJson.map((json) => Article.fromJson(json)).toList();

    if (articles.isEmpty) {
      debugPrint('Article doesn\'t exist for $date');
    }

    return articles;
  }
}
