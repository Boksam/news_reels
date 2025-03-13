import 'package:flutter/material.dart';
import 'package:news_reels/config/api_config.dart';
import 'package:http/http.dart' as http;

/// This service is to help sending API requests.
class ApiService {
  final String baseUrl;
  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? ApiConfig.baseUrl;

  Uri getUri(String endpoint, Map<String, dynamic>? queryParams) {
    if (queryParams == null) return Uri.http(baseUrl, endpoint);

    final stringQueryParams =
        queryParams.map((key, value) => MapEntry(key, value.toString()));

    return Uri.http(baseUrl, endpoint, stringQueryParams);
  }

  /// Sends http request and returns [http.Reponse].
  Future<http.Response> get(
      String endpoint, Map<String, dynamic>? queryParams) async {
    final uri = getUri(endpoint, queryParams);
    debugPrint("Sending GET request to: $uri");
    return await http.get(uri);
  }
}
