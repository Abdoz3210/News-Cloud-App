class ArticalModel {
  final String? image;
  final String? title;
  final String? aurthor;
  final String? descriptation;
  final String? content;
  final String? url;
  final String? publishedAt;
  final dynamic source;

  ArticalModel({
    this.aurthor,
    this.content,
    this.descriptation,
    this.image,
    this.title,
    this.url,
    this.publishedAt,
    this.source,
  });

  int get readTimeMinutes {
    if (content == null || content!.isEmpty) return 1;
    final wordCount = content!.trim().split(RegExp(r'\s+')).length;

    final minutes = (wordCount / 200).ceil();
    return minutes;
  }

  String get sourceName {
    if (source == null) return 'Unknown';
    if (source is Map) return source['name'] ?? 'Unknown';
    if (source is Map) return source['id'] ?? 'Unknown';
    return source.toString();
  }

  String get relativeTime {
    if (publishedAt == null) return '';

    final published = DateTime.tryParse(publishedAt!);

    if (published == null) return '';

    final difference = DateTime.now().difference(published);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  factory ArticalModel.fromjson(dynamic json) {
    return ArticalModel(
      title: json['title'],
      aurthor: json['author'],
      content: json['content'],
      descriptation: json['description'],
      image: json['urlToImage'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      source: json['source'],
    );
  }
}
