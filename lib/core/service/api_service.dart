import 'package:flutter/material.dart';
import 'package:news_reels/core/config/api_config.dart';
import 'package:http/http.dart' as http;

/// This service is to help sending API requests.
class ApiService {
  final String baseUrl;
  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? ApiConfig.baseUrl;

  Uri getUri(String endpoint, Map<String, dynamic>? queryParams) {
    final uri = Uri.http(baseUrl, endpoint, queryParams);
    // if (queryParams == null) return uri;

    // uri.replace(
    //     queryParameters:
    //         queryParams.map((key, value) => MapEntry(key, value.toString())));
    return uri;
  }

  /// Sends http request and returns [http.Reponse].
  Future<http.Response> get(
      String endpoint, Map<String, dynamic>? queryParams) async {
    final uri = getUri(endpoint, queryParams);
    debugPrint("Sending request to: $uri");
    return await http.get(uri);
  }
}
