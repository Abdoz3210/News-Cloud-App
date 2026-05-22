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

  Future<List<ArticalModel>> getGeneral({required String category}) async {
    final Response response = await dio.get(
      'https://newsapi.org/v2/top-headlines?apiKey=232668304d4342d5a1a6407d88450a86&category=$category',
    );
    Map<String, dynamic> josnData = response.data;
    List<dynamic> articals = josnData['articles'];

    List<ArticalModel> articalList = [];

    for (var artical in articals) {
      ArticalModel articalModel = ArticalModel.fromjson(artical);
      articalList.add(articalModel);
    }
    // print(articalList);
    return articalList;
  }
}
