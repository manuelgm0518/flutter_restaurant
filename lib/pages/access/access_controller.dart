import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_button.dart';
import 'package:flutter_restaurant/components/restaurants/restaurant_editor.dart';
import 'package:flutter_restaurant/config/app_pages.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:flutter_restaurant/providers/restaurants_provider.dart';
import 'package:flutter_restaurant/services/session_service.dart';
import 'package:get/get.dart';

class AccessController extends GetxController with SingleGetTickerProviderMixin, StateMixin<List<Restaurant>> {
  late TabController tabController;
  final userForm = GlobalKey<FormState>();
  final userEmailField = TextEditingController();
  final buttonStatus = GlobalKey<CustomButtonState>();

  var tabIndex = 0.obs;
  var selectedRestaurantIndex = (-1).obs;

  Future<void> userLogIn() async {
    buttonStatus.currentState?.setStatus(CustomButtonStatus.LOADING);
    if (userForm.currentState?.validate() ?? false) {
      await SessionService.to.userLogIn(userEmailField.text);
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  Future<void> restaurantLogIn() async {
    buttonStatus.currentState?.setStatus(CustomButtonStatus.LOADING);
    final restaurant = state![selectedRestaurantIndex.value];
    await SessionService.to.restaurantLogIn(restaurant);
    Get.offAllNamed(AppRoutes.RESTAURANT(restaurant.slug));
  }

  Future<void> createRestaurant() async {
    final res = await RestaurantEditor.show();
    if (res != null) {
      await SessionService.to.restaurantLogIn(res);
      Get.offAllNamed(AppRoutes.RESTAURANT(res.slug));
    }
  }

  void getRestaurants() {
    RestaurantsProvider.to.getRestaurants().then((result) {
      final data = result.body;
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  @override
  void onInit() {
    tabController = new TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabIndex(tabController.index);
      if (tabController.index == 0) selectedRestaurantIndex(-1);
    });
    getRestaurants();
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
