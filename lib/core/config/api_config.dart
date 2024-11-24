/// Defines Api configurations. This could have configs for
/// development, test, production environment.
class ApiConfig {
  static const development = {'baseUrl': 'localhost:3000'};

  static const current = development;
  static String get baseUrl => current['baseUrl']!;
}

/// Configures Api endpoints.
class ApiEndPoints {
  static String articles(DateTime date) => '/api/articles';
  static String articlesById(int id) => '/api/articles/$id';
}
