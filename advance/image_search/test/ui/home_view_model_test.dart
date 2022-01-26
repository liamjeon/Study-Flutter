import 'package:flutter_test/flutter_test.dart';
import 'package:image_search/data/pixabay_api.dart';
import 'package:image_search/data/photo_api_repository.dart';
import 'package:image_search/model/photo.dart';
import 'package:image_search/ui/viewmodel/home_view_model.dart';

void main() {
  test('Stream이 잘 동작해야 한다.', () async {
    final viewModel = HomeViewModel(FakePhotoApiRepository());

    await viewModel.fetch('apple');
    await viewModel.fetch('iphobn');

    // final List<Photo> result = fakeJson.map((e) => Photo.fromJson(e)).toList();

    expect(
      viewModel.photoStream,
      emitsInOrder([
        equals([]),
      ]),
    );
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<List<Photo>> fetch(String query) async {
    Future.delayed(const Duration(microseconds: 500));

    return fakeJson.map((e) => Photo.fromJson(e)).toList();
  }

  List<Map<String, dynamic>> fakeJson = [
    {
      "id": 256261,
      "pageURL":
          "https://pixabay.com/photos/apple-books-still-life-fruit-food-256261/",
      "type": "photo",
      "tags": "apple, books, still life",
      "previewURL":
          "https://cdn.pixabay.com/photo/2014/02/01/17/28/apple-256261_150.jpg",
      "previewWidth": 150,
      "previewHeight": 99,
      "webformatURL":
          "https://pixabay.com/get/g4727fbcdf697bd2b3c0651910119734bc3bd937520eedf76d8268940d812cf93d5e7cc3e220ab00ecf15a900ad372985_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 423,
      "largeImageURL":
          "https://pixabay.com/get/gdae77f359e311c9442d55da31cce479c0e2936dfda6ef9b07da16eabffefafc6d55923a9bb2e2e2d78e58f5b66ecff003f27f5a0c9e95eff4ba2dad2d0d6933e_1280.jpg",
      "imageWidth": 4928,
      "imageHeight": 3264,
      "imageSize": 2987083,
      "views": 397731,
      "downloads": 189823,
      "collections": 3669,
      "likes": 977,
      "comments": 218,
      "user_id": 143740,
      "user": "jarmoluk",
      "userImageURL":
          "https://cdn.pixabay.com/user/2019/09/18/07-14-26-24_250x250.jpg"
    },
    {
      "id": 1122537,
      "pageURL":
          "https://pixabay.com/photos/apple-water-droplets-fruit-moist-1122537/",
      "type": "photo",
      "tags": "apple, water droplets, fruit",
      "previewURL":
          "https://cdn.pixabay.com/photo/2016/01/05/13/58/apple-1122537_150.jpg",
      "previewWidth": 150,
      "previewHeight": 95,
      "webformatURL":
          "https://pixabay.com/get/g85ebd5a59314ba6473d71483fc63d286ff777e6f0897927b0e63919f1ea3a09960faa2e56ceacf455630af8ec580a55f84c041dea4b774173d10a8d61c357df5_640.jpg",
      "webformatWidth": 640,
      "webformatHeight": 409,
      "largeImageURL":
          "https://pixabay.com/get/g8e254f38c83b06ec9f393cc0bc76f571cef20ebea0c88851e0640007815638cd2437c221bf48d13c4c2b164bfd0c7ce3115cb3561b228a19360e6d65b804343e_1280.jpg",
      "imageWidth": 4752,
      "imageHeight": 3044,
      "imageSize": 5213632,
      "views": 240433,
      "downloads": 135348,
      "collections": 3347,
      "likes": 1017,
      "comments": 158,
      "user_id": 1445608,
      "user": "mploscar",
      "userImageURL":
          "https://cdn.pixabay.com/user/2016/01/05/14-08-20-943_250x250.jpg"
    },
  ];
}
