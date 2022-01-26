import 'dart:convert';

import 'package:image_search/data/photo_api_repository.dart';
import 'package:image_search/model/photo.dart';
import 'package:http/http.dart' as http;

class PixabayApi implements PhotoApiRepository{
  final baseUrl = 'https://pixabay.com/api';
  final key = '25403848-401f4ad59ff6c1ede75df021b&q';

  @override
  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/?key=$key&q=$query&image_type=photo'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits']; //hits : 아직 Map 형태
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
