import 'package:flutter_restaurant/config/app_pages.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:flutter_restaurant/providers/restaurants_provider.dart';
import 'package:flutter_restaurant/services/session_service.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController with StateMixin<Restaurant> {
  bool owner = false;
  void getRestaurant() {
    change(null, status: RxStatus.loading());
    final slug = Get.parameters['slug'] as String;
    if (SessionService.to.restaurant?.slug == slug) owner = true;
    RestaurantsProvider.to.getRestaurant(slug).then((result) {
      final data = result.body;
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  Future<void> logOut() async {
    await Get.offAllNamed(AppRoutes.ACCESS);
    SessionService.to.logOut();
  }

  @override
  void onInit() {
    getRestaurant();
    super.onInit();
  }
}
