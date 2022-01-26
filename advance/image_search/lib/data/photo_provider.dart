import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search/data/api.dart';
import 'package:image_search/model/photo.dart';

//InheritedWidget 문서에있는 코드임
class PhotoProvider extends InheritedWidget {
  final PixabayApi api;

  final _photoStreamContoller = StreamController<List<Photo>>()..add([]); //스트림을 관리하는 컨트롤러
  Stream<List<Photo>> get photoStream => _photoStreamContoller.stream;

  PhotoProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : super(key: key, child: child);

  static PhotoProvider of(BuildContext context){ //context : widget tree의 정보를 갖고있음.
    final PhotoProvider? result =
        context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No PixabayApi found in context');
    return result!;
  }

  Future<void> fetch(String query) async {
    final result = await api.fetch(query);
    _photoStreamContoller.add(result);
  }

  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api;
  }
}
