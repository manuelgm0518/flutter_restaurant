import 'package:flutter/cupertino.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:flutter_restaurant/providers/restaurants_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<Restaurant>> {
  final filterField = TextEditingController();
  final filtered = <Restaurant>[];
  var filterText = ''.obs;

  void filter([List<String> foodTypes = const []]) {
    filtered.assignAll(
      state?.where((element) {
            final hasFoodType = foodTypes.isEmpty || element.food_type.toList().any((element) => foodTypes.contains(element));
            return hasFoodType && element.name.contains(filterText.value);
          }).toList() ??
          [],
    );
    update();
  }

  void getRestaurants() {
    RestaurantsProvider.to.getRestaurants().then((result) {
      final data = result.body;
      change(data, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
    filter();
  }

  @override
  void onInit() {
    filterField.addListener(() {
      filterText(filterField.text);
    });
    debounce(
      filterText,
      (_) {
        filter();
      },
      time: 1.seconds,
    );
    getRestaurants();
    super.onInit();
  }

  @override
  void onReady() async {
    await 1.seconds.delay();
    filter();
    super.onReady();
  }
}
