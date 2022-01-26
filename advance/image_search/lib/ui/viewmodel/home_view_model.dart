import 'dart:async';

import 'package:image_search/data/pixabay_api.dart';
import 'package:image_search/data/photo_api_repository.dart';
import 'package:image_search/model/photo.dart';

class HomeViewModel {
  final PhotoApiRepository repository;

  final _photoStreamContoller = StreamController<List<Photo>>()..add([]); //스트림을 관리하는 컨트롤러
  Stream<List<Photo>> get photoStream => _photoStreamContoller.stream;

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async {
    final result = await repository.fetch(query);
    _photoStreamContoller.add(result);
  }
}