import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_reels/config/api_config.dart';
import 'package:news_reels/service/api_service.dart';
import 'package:news_reels/models/article.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Constants
const int defaultTimeframeHours = 24;
const int defaultDeleteHours = 24;

class ArticleRepository {
  final ApiService _apiService;
  static Database? _database;

  // Constructor with optional ApiService dependency injection
  ArticleRepository(ApiService? apiService)
      : _apiService = apiService ?? ApiService();

  // Database getter with lazy initialization
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  /// Initiates database.
  ///
  /// It will create essential tables like articles.
  /// NOTE: This should be fixed if the model changes.
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
            one_line_summary TEXT,
            summary_md TEXT,
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

  /// Deletes articles older than the specified timeframe
  ///
  /// @params hours The number of hours to keep (defaults to 24 hours)
  /// @return The number of deleted records
  Future<void> deleteArticles({int hours = defaultDeleteHours}) async {
    final db = await database;
    final DateTime cutoffTime =
        DateTime.now().toUtc().subtract(Duration(hours: hours));

    final deletedCount = await db.delete('articles',
        where: 'datetime(created_at) < datetime(?)',
        whereArgs: [cutoffTime.toIso8601String()]);

    debugPrint('Delete $deletedCount articles older than $cutoffTime');
  }

  /// Fetches articles from API and stores them in the local database
  ///
  /// @params timeframe The time range in hours to fetch articles for (defaults to 24 hours)
  /// @return The number of articles fetched and stored
  Future<void> fetchAndStoreArticles(
      {int timeframe = defaultTimeframeHours}) async {
    final response = await _apiService
        .get(ApiEndPoints.articles(), {'timeframe': timeframe});

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

  /// Retrieves articles from the local database for a specific timeframe
  ///
  /// @param timeframe The time range in hours to retrieve articles for (defaults to 24 hours)
  /// @return List of articles within the specified timeframe
  Future<List<Article>?> getArticles(
      {int timeframe = defaultTimeframeHours}) async {
    final db = await database;

    final DateTime endTime = DateTime.now().toUtc();
    final DateTime startTime = endTime.subtract(Duration(hours: timeframe));

    final List<Map<String, dynamic>> articlesJson = await db.query('articles',
        where: 'datetime(created_at) BETWEEN datetime(?) AND datetime(?)',
        whereArgs: [startTime.toIso8601String(), endTime.toIso8601String()],
        orderBy: 'datetime(created_at) DESC');

    final List<Article> articles =
        articlesJson.map((json) => Article.fromJson(json)).toList();

    if (articles.isEmpty) {
      debugPrint('Article doesn\'t exist within the last $timeframe hours');
    }

    return articles;
  }
}
