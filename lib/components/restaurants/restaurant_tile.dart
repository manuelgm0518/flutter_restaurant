import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_network_image.dart';
import 'package:flutter_restaurant/components/food_types/food_type_list.dart';
import 'package:flutter_restaurant/config/app_pages.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile(this.restaurant, {Key? key}) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
          CustomNetworkImage(restaurant.logo, width: Get.width / 5, height: Get.width / 5, placeholderColor: kPrimaryColor),
          Positioned(
            right: -kSpacing3,
            bottom: -kSpacing2,
            child: Card(
              color: Colors.amber,
              child: Text(restaurant.rating?.toStringAsFixed(1) ?? '0.0', style: Get.textTheme.bodyText2?.copyWith(color: Colors.white)).left([
                Icon(UniconsSolid.star, color: Colors.white, size: 15).pr1,
              ]).pxy(2, 1),
            ),
          ),
        ]),
        kSpacerX4,
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
          Text(restaurant.name, style: Get.textTheme.headline6?.copyWith(color: Colors.black)),
          kSpacerY2,
          FoodTypeList(
            restaurant.food_type.toList(),
            key: ValueKey(restaurant.food_type.toString()),
            scrollable: false,
            backgroundColor: kSecondaryColor.variants.light,
            textColor: kSecondaryColor,
            small: true,
          ),
        ]).expanded(),
      ]),
    ).mouse(() {
      Get.toNamed(AppRoutes.RESTAURANT(restaurant.slug));
    });
  }
}
