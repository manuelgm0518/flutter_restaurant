import 'package:flutter_restaurant/config/app_settings.dart';
import 'package:flutter_restaurant/models/FoodType.dart';
import 'package:get/get.dart';

class FoodTypesProvider extends GetConnect {
  Future<Response<List<FoodType>>> getFoodTypes() => get('/food_types/', decoder: (res) => List<FoodType>.from(res.map((x) => FoodType.fromMap(x))));

  Future<Response<FoodType>> postFoodType(FoodType foodType) => post('/food_types/', foodType.toMap());

  Future<Response<FoodType>> getFoodType(String slug) => get('/food_types/$slug');

  Future<Response<FoodType>> putFoodType(String slug, FoodType foodType) => put('/food_types/$slug', foodType.toMap());

  Future<Response<FoodType>> patchFoodType(String slug, Map<String, dynamic> foodTypeFields) => patch('/food_types/$slug', foodTypeFields);

  Future<Response> deleteFoodType(String slug) => delete('/food_types/$slug', decoder: (res) => res);

  static FoodTypesProvider get to => Get.find<FoodTypesProvider>();
  @override
  void onInit() {
    httpClient.baseUrl = AppSettings.API;
    httpClient.defaultDecoder = (value) => new FoodType.fromMap(value);
  }
}
