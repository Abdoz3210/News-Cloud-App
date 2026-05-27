class ArticalModel {
  final String? image;
  final String title;
  final String? aurther;
  final String? descriptation;
  final String? content;
  ArticalModel({
    required this.aurther,
    required this.content,
    required this.descriptation,
    required this.image,
    required this.title,
  });

  factory ArticalModel.fromjson(dynamic json) {
    return ArticalModel(
      aurther: json['author'],
      content: json['content'],
      descriptation: json['description'],
      image: json['urlToImage'],
      title: json['title'],
    );
  }
}
