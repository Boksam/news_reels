class ApiConfig {
  static const development = {'baseUrl': 'localhost:3000'};

  static const current = development;
}

class ApiEndPoints {
  static String articles(DateTime date) => '/api/articles';
  static String articlesById(int id) => '/api/articles/$id';
}
