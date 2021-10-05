import 'package:flutter_restaurant/config/app_pages.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:get/get.dart';

class SessionService extends GetxService {
  Restaurant? restaurant;
  String? userEmail;

  bool get loggedAsRestaurant => restaurant != null;
  bool get loggedAsUser => userEmail != null;

  Future<void> userLogIn(String email) async {
    this.userEmail = email;
    await 1.seconds.delay();
  }

  Future<void> restaurantLogIn(Restaurant restaurant) async {
    this.restaurant = restaurant;
    await 1.seconds.delay();
  }

  Future<void> logOut() async {
    await Get.offAllNamed(AppRoutes.ACCESS);
    restaurant = null;
    userEmail = null;
  }

  static SessionService get to => Get.find<SessionService>();
  Future<SessionService> init() async {
    return this;
  }
}
