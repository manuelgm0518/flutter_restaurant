import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant/config/app_pages.dart';
import 'package:flutter_restaurant/providers/food_types_provider.dart';
import 'package:flutter_restaurant/services/session_service.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';

import 'config/app_themes.dart';
import 'providers/restaurants_provider.dart';
import 'providers/reviews_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initServices();
  setScreenColors(statusBar: kLightColor, navigationBar: kLightColor);
  runApp(FlutterRestaurant());
}

Future<void> initServices() async {
  await Get.putAsync(() => SessionService().init());
  Get.put(FoodTypesProvider());
  Get.put(ReviewsProvider());
  Get.put(RestaurantsProvider());
}

class FlutterRestaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.main,
        getPages: AppPages.routes,
        initialRoute: '/access',
      ),
    );
  }
}
