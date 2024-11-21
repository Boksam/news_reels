import 'package:http/http.dart' as http;

class ApiConfig {
  static const development = {'baseUrl': 'localhost:3000'};

  static const current = development;
  static String get baseUrl => current['baseUrl']!;
}

class ApiEndPoints {
  static String articles(DateTime date) => '/api/articles';
  static String articlesById(int id) => '/api/articles/$id';
}

class ApiService {
  final String baseUrl;
  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? ApiConfig.baseUrl;

  Uri getUri(String endpoint, [Map<String, dynamic>? queryParams]) {
    final uri = Uri.parse('$baseUrl$endpoint');

    if (queryParams == null) return uri;

    uri.replace(
        queryParameters:
            queryParams.map((key, value) => MapEntry(key, value.toString())));
    return uri;
  }

  Future<http.Response> get(String endpoint,
      [Map<String, dynamic>? queryParams]) async {
    final uri = getUri(endpoint);
    return await http.get(uri);
  }
}
