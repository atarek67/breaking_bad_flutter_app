import '../../constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) => true,
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 15 * 1000, //15 Seconds
      receiveTimeout: 15 * 1000, //15 Seconds
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      if (kDebugMode) {
        print(response.data.toString());
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author ': charName});
      if (kDebugMode) {
        print(response.data.toString());
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}
