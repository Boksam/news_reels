import 'package:news_reels/utils/url_helper.dart';

class Article {
  final int id;
  final String? headline;
  final String? content;
  final String? oneLineSummary;
  final String? summaryMd;
  final String? section;
  final String? type;
  final String? thumbnail;
  final String? language;
  final String? url;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Article({
    required this.id,
    this.headline,
    this.content,
    this.oneLineSummary,
    this.summaryMd,
    this.section,
    this.type,
    this.thumbnail,
    this.language,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      id: json['id'],
      headline: json['headline'],
      content: json['content'],
      oneLineSummary: json['one_line_summary'],
      summaryMd: json['summary_md'],
      section: json['section'],
      type: json['type'],
      thumbnail: getOriginalImageFromUrl(json['thumbnail']),
      language: json['language'],
      url: json['url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null);

  Map<String, Object?> toMap() => {
        'id': id,
        'headline': headline,
        'content': content,
        'one_line_summary': oneLineSummary,
        'summary_md': summaryMd,
        'section': section,
        'type': type,
        'thumbnail': thumbnail,
        'language': language,
        'url': url,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
