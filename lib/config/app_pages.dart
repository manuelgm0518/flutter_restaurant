// ignore_for_file: non_constant_identifier_names
import 'package:flutter_restaurant/pages/home/home_page.dart';
import 'package:flutter_restaurant/pages/access/access_page.dart';
import 'package:flutter_restaurant/pages/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: BindingsBuilder<dynamic>(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.ACCESS,
      page: () => AccessPage(),
      binding: BindingsBuilder<dynamic>(() {
        Get.put<AccessController>(AccessController());
      }),
    ),
    GetPage(
      name: AppRoutes.RESTAURANT(),
      page: () => RestaurantPage(),
      binding: BindingsBuilder<dynamic>(() {
        Get.put<RestaurantController>(RestaurantController());
      }),
    ),
  ];
}

abstract class AppRoutes {
  static const HOME = '/';
  static const ACCESS = '/access';
  static String RESTAURANT([String? slug]) => '/restaurant/${slug ?? ":slug"}';
}
