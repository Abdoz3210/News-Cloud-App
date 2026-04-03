import 'package:dio/dio.dart';
import 'package:news_app/Models/articales_model.dart';

class NewsServce {
  final Dio dio;

  NewsServce(this.dio);

  // void getSports() async {
  //   final Response response = await dio.get(
  //     'https://newsapi.org/v2/everything?q=Sports&apiKey=232668304d4342d5a1a6407d88450a86',
  //   );
  // }

  Future<List<ArticalModel>> getGeneral() async {
    final Response response = await dio.get(
      'https://newsapi.org/v2/top-headlines?apiKey=232668304d4342d5a1a6407d88450a86&category=general',
    );
    Map<String, dynamic> josnData = response.data;
    List<dynamic> articales = josnData['articles'];

    List<ArticalModel> articalList = [];

    for (var articale in articales) {
      ArticalModel articalModel = ArticalModel(
        aurther: articale['author'],
        content: articale['content'],
        descriptation: articale['description'],
        image: articale['urlToImage'],
        title: articale['title'],
      );
      articalList.add(articalModel);
    }
    // print(articalList);
    return articalList;
  }
}
