import 'package:flutter/foundation.dart';

/// Convert image url to high resolution image url
String getOriginalImageFromUrl(String url, {int width = 1900, int dpr = 1}) {
  /// Returns original url if the url is not guardian's image or
  /// has invalid format. Return url is like
  /// "https://media.guim.co.uk/{assetId}/{originalSize}/master/{width}.jpg"
  if (!url.contains('media.guim.co.uk')) {
    debugPrint("This url is not gurdian's image");
    return url;
  }

  final uri = Uri.parse(url);
  final pathSegments = uri.pathSegments;

  if (pathSegments.length < 3) {
    debugPrint("Invalid PathSegments");
    return url;
  }

  final assetId = pathSegments[0];
  final dimension = pathSegments[1];

  final originalSize = dimension.split('_');

  if (originalSize.length < 4) {
    return url;
  }

  final originalWidth = originalSize[2];

  try {
    final newUrl =
        Uri(scheme: 'https', host: 'media.guim.co.uk', pathSegments: [
      assetId,
      dimension,
      'master',
      '$originalWidth.jpg',
    ], queryParameters: {
      'width': width.toString(),
      'dpr': dpr.toString(),
      's': 'none',
      'crop': 'none',
    }).toString();
    return newUrl;
  } catch (e) {
    debugPrint("Error converting Guardian URL: $e");
    return url;
  }
}
