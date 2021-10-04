import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_network_image.dart';
import 'package:flutter_restaurant/components/food_types/food_type_list.dart';
import 'package:flutter_restaurant/components/restaurants/restaurant_editor.dart';
import 'package:flutter_restaurant/components/reviews/review_tile.dart';
import 'package:flutter_restaurant/components/status/empty.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'restaurant_controller.dart';
export 'restaurant_controller.dart';

class RestaurantPage extends GetView<RestaurantController> {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.max, children: [
        kSpacerY,
        controller.obx(
          (state) {
            return Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.max, children: [
              _RestaurantHeader(),
              FoodTypeList(state?.food_type.toList() ?? []).py,
              kSpacerY4,
              _RestaurantReviews().pLTRB(4, 0, 4, 4).expanded(),
            ]);
          },
          onLoading: CircularProgressIndicator().centered(),
          onError: (error) => Text(error.toString(), style: Get.textTheme.headline1?.copyWith(color: kErrorColor)).centered(),
        ).expanded(),
      ]),
    ).safeArea();
  }
}

class _RestaurantHeader extends GetView<RestaurantController> {
  const _RestaurantHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          if (!controller.owner) Icon(UniconsLine.angle_left, color: kDarkColor, size: 25).p3.mouse(() => Get.back()),
          kSpacer,
          if (controller.owner) ...[
            Icon(UniconsLine.edit_alt, color: kDarkColor, size: 25).p3.mouse(() async {
              final res = await RestaurantEditor.show(state);
              if (res != null) controller.getRestaurant();
            }),
            Icon(UniconsLine.signout, color: kDarkColor, size: 25).p3.mouse(() => controller.logOut()),
          ]
        ]).pxy(4, 3),
        Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
          CustomNetworkImage(state?.logo, width: Get.width / 4, height: Get.width / 4, placeholderColor: kPrimaryColor),
          Positioned(
            right: -kSpacing4,
            bottom: -kSpacing3,
            child: Card(
              color: Colors.amber,
              child: Text(state?.rating?.toStringAsFixed(1) ?? '0.0', style: Get.textTheme.subtitle1?.copyWith(color: Colors.white)).left([
                Icon(UniconsSolid.star, color: Colors.white, size: 20).pr1,
              ]).pxy(2, 1),
            ),
          ),
        ]).centered(),
        kSpacerY4,
        Text(state?.name ?? '', style: Get.textTheme.headline4?.copyWith(color: Colors.black), textAlign: TextAlign.center),
        Text(state?.name ?? '', style: Get.textTheme.bodyText2?.copyWith(color: Colors.black), textAlign: TextAlign.center),
      ]),
    );
  }
}

class _RestaurantReviews extends GetView<RestaurantController> {
  const _RestaurantReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('Reseñas', style: Get.textTheme.headline5?.copyWith(color: Colors.black)).pr.right([
        controller.obx((state) => Text('(${state?.reviews?.length ?? 0})', style: Get.textTheme.headline6?.copyWith(color: kDarkColor, fontWeight: FontWeight.normal))),
      ]).px2,
      kSpacerY3,
      Card(
        child: controller.obx((state) {
          return (state?.reviews?.length ?? 0) == 0
              ? EmptyIndicator(message: 'No hay reseñas todavía').width(Get.width / 2).centered()
              : ListView.builder(
                  physics: kBouncyScroll,
                  itemCount: state?.reviews?.length ?? 0,
                  padding: kPadding4,
                  itemBuilder: (context, index) {
                    final review = state!.reviews![index];
                    return ReviewTile(review: review).p3.bottom([kDivider]);
                  },
                );
        }),
      ).expanded(),
    ]);
  }
}
