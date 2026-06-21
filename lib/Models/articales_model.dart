class ArticalModel {
  final String? image;
  final String? title;
  final String? author;
  final String? descriptation;
  final String? content;
  final String? url;
  final String? publishedAt;
  final dynamic source;
  final String? category;

  ArticalModel({
    this.author,
    this.content,
    this.descriptation,
    this.image,
    this.title,
    this.url,
    this.publishedAt,
    this.source,
    this.category,
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

  String get formattedDate {
    if (publishedAt == null) return '';
    final date = DateTime.tryParse(publishedAt!);
    if (date == null) return '';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  List<String> get contentParagraphs {
    if (content == null || content!.isEmpty) return [];

    final cleaned = content!.replaceAll(RegExp(r'\[\+\d+ chars\]'), '');

    return cleaned
        .split('\n')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
  }

  String get authorBio {
    if (author == null) return 'A contributor to ${sourceName}.';
    return '$author is a contributor covering stories for $sourceName, '
        'exploring the intersection of culture, technology, and society.';
  }

  factory ArticalModel.fromjson(Map<String, dynamic> json, {String? category}) {
    return ArticalModel(
      title: json['title'],
      author: json['author'],
      content: json['content'],
      descriptation: json['description'],
      image: json['urlToImage'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      source: json['source'],
      category: category,
    );
  }
}
