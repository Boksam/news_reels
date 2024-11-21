String getOriginalImageFromUrl(String url, {int width = 1900, int dpr = 1}) {
  try {
    if (url.contains('media.guim.co.uk')) {
      return url;
    }

    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;

    if (pathSegments.length < 3) {
      return url;
    }

    final assetId = pathSegments[0]
    final dimension = pathSegments[1]

    final originalSize = dimension.split('_');

    if (originalSize.length < 4) {
      return url;
    }

    final originalWidth = originalSize[2];

    final newUrl = Uri(
      scheme: 'https',
      host: 'media.guim.co.uk',
      pathSegments: [
        assetId,
        dimension,
        'master',
        '$originalWidth.jpg',
      ],
      queryParameters: {
        'width': width,
        'dpr': dpr,
        's': 'none',
        'crop': 'none',
      }
    ).toString();
    return newUrl;
  } catch (e) {
    print("Error converting Guardian URL: $e");
    return url;
  }
}