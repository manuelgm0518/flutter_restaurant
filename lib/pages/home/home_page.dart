import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_text_field.dart';
import 'package:flutter_restaurant/components/food_types/food_type_selector.dart';
import 'package:flutter_restaurant/components/restaurants/restaurant_tile.dart';
import 'package:flutter_restaurant/components/empty.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/pages/home/home_controller.dart';
import 'package:flutter_restaurant/services/session_service.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
export 'home_controller.dart';
export 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          Text(SessionService.to.userEmail ?? '', style: Get.textTheme.headline6?.copyWith(color: kDarkColor), softWrap: false, overflow: TextOverflow.ellipsis).expanded(),
          kSpacerX,
          Icon(UniconsLine.signout, color: kDarkColor, size: 25).p3.mouse(() {
            SessionService.to.logOut();
          })
        ]).px4,
        kSpacerY,
        Text('Restaurantes', style: Get.textTheme.headline4?.copyWith(color: Colors.black)).px4,
        kSpacerY4,
        CustomTextField(
          label: 'Buscar...',
          prefix: Icon(UniconsLine.search),
          controller: controller.filterField,
          whiteBackground: true,
        ).px5,
        kSpacerY4,
        FoodTypeSelector(
          whiteChipBackground: true,
          onSelect: (foodTypes) => controller.filter(foodTypes),
        ).width(Get.width * 2).scrollable(direction: Axis.horizontal, padding: kPaddingX4),
        kSpacerY4,
        Card(
          child: controller.obx(
            (state) {
              if (controller.filtered.isEmpty)
                return EmptyIndicator(
                  message: 'No se encontraron restaurantes',
                ).p5.centered();
              return ListView.builder(
                physics: kBouncyScroll,
                padding: kPaddingX4,
                itemCount: controller.filtered.length,
                itemBuilder: (context, index) {
                  final restaurant = controller.filtered[index]; //state![index];
                  return RestaurantTile(restaurant, key: ValueKey(restaurant.slug)).py4.bottom([kDivider]);
                },
              );
            },
            onLoading: CircularProgressIndicator().centered(),
            onEmpty: EmptyIndicator(
              message: 'No se encontraron restaurantes',
            ).p5.centered(),
          ),
        ).px4.expanded(),
      ]).py5,
    ).safeArea();
  }
}
