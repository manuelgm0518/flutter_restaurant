import 'package:flutter_restaurant/config/app_settings.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:get/get.dart';

class RestaurantsProvider extends GetConnect {
  Future<Response<List<Restaurant>>> getRestaurants() => get('/restaurants/', decoder: (res) => List<Restaurant>.from(res.map((x) => Restaurant.fromMap(x))));

  Future<Response<Restaurant>> postRestaurant(Restaurant restaurant) => post('/restaurants/', restaurant.toMap());

  Future<Response<Restaurant>> getRestaurant(String slug) => get('/restaurants/$slug/');

  Future<Response<Restaurant>> putRestaurant(String slug, Restaurant restaurant) => put('/restaurants/$slug/', restaurant.toMap());

  Future<Response<Restaurant>> patchRestaurant(String slug, Map<String, dynamic> restaurantFields) => patch('/restaurants/$slug/', restaurantFields);

  Future<Response> deleteRestaurant(String slug) => delete('/restaurants/$slug/', decoder: (res) => res);

  static RestaurantsProvider get to => Get.find<RestaurantsProvider>();
  @override
  void onInit() {
    httpClient.baseUrl = AppSettings.API;
    httpClient.defaultDecoder = (value) => new Restaurant.fromMap(value);
    httpClient.followRedirects = true;
  }
}
