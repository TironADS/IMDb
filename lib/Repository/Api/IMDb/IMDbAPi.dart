import 'dart:convert';
import 'package:http/http.dart';
import 'package:imdb/Repository/Api/api_client.dart';
import 'package:imdb/Repository/ModelClass/IMDbModel.dart';

class IMDbApi{

  ApiClient apiClient=ApiClient();

  Future<ImDbModel>getIMDb() async{
    String trendingpath ='https://imdb-top-100-movies.p.rapidapi.com/top32';
    var body={};


    Response response= await apiClient.invokeAPI(trendingpath, 'GET', body);
    return ImDbModel.fromJson(jsonDecode(response.body));
  }



}