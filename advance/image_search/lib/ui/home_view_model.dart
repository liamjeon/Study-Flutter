import 'dart:async';

import 'package:image_search/data/api.dart';
import 'package:image_search/model/photo.dart';

class HomeViewModel {
  final PixabayApi api;

  final _photoStreamContoller = StreamController<List<Photo>>()..add([]); //스트림을 관리하는 컨트롤러
  Stream<List<Photo>> get photoStream => _photoStreamContoller.stream;

  HomeViewModel(this.api);

  Future<void> fetch(String query) async {
    final result = await api.fetch(query);
    _photoStreamContoller.add(result);
  }
}