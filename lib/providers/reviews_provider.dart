import 'package:flutter_restaurant/config/app_settings.dart';
import 'package:flutter_restaurant/models/Review.dart';
import 'package:get/get.dart';

class ReviewsProvider extends GetConnect {
  Future<Response<List<Review>>> getReviews() => get('/reviews/', decoder: (res) => List<Review>.from(res.map((x) => Review.fromMap(x))));

  Future<Response<Review>> postReview(Review review) => post('/reviews/', review.toMap());

  Future<Response<Review>> getReview(String slug) => get('/reviews/$slug');

  Future<Response<Review>> putReview(String slug, Review review) => put('/reviews/$slug', review.toMap());

  Future<Response<Review>> patchReview(String slug, Map<String, dynamic> reviewFields) => patch('/reviews/$slug', reviewFields);

  Future<Response> deleteReview(String slug) => delete('/reviews/$slug', decoder: (res) => res);

  static ReviewsProvider get to => Get.find<ReviewsProvider>();
  @override
  void onInit() {
    httpClient.baseUrl = AppSettings.API;
    httpClient.defaultDecoder = (value) => new Review.fromMap(value);
  }
}
