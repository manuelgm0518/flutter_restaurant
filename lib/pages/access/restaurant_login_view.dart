import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_button.dart';
import 'package:flutter_restaurant/components/custom/custom_network_image.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'access_controller.dart';

class RestaurantLogInView extends GetView<AccessController> {
  const RestaurantLogInView({Key? key}) : super(key: key);

  Widget _restaurantItem(Restaurant restaurant, {bool selected = false, required void Function() onPressed}) {
    final hasLogo = restaurant.logo?.isURL ?? false;
    return Stack(
      fit: StackFit.expand,
      children: [
        selected
            ? Container(color: kSecondaryColor)
            : !hasLogo
                ? DefaultPlaceholder()
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken),
                    child: CustomNetworkImage(restaurant.logo),
                  ),
        Text(
          restaurant.name,
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyText1?.copyWith(color: hasLogo || selected ? Colors.white : Colors.black),
        ).p3.aligned(Alignment.center),
      ],
    ).rounded().mouse(onPressed);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
      Text('Ingresa como Restaurante', style: Get.textTheme.headline4?.copyWith(color: Colors.black)).px4,
      Text('Administra tu negocio y mira lo que opinan tus clientes!', style: Get.textTheme.bodyText2?.copyWith(color: Colors.black)).px4,
      kSpacerY2,
      kDivider.px4,
      controller.obx(
        (state) => GridView.builder(
          physics: kBouncyScroll,
          itemCount: (state?.length ?? 0) + 1,
          padding: kPadding4,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: kSpacing, mainAxisSpacing: kSpacing),
          itemBuilder: (context, index) {
            if ((state?.length ?? 0) == index)
              return CustomButton.flat(
                child: Icon(UniconsLine.plus_circle, size: 45),
                color: kSecondaryColor,
                onPressed: () => controller.createRestaurant(),
              );
            final restaurant = state![index];
            return Obx(() {
              final selected = controller.selectedRestaurantIndex.value == index;
              return _restaurantItem(restaurant, selected: selected, onPressed: () {
                controller.selectedRestaurantIndex(selected ? -1 : index);
              });
            });
          },
        ).expanded(),
        onError: (error) => Text(error ?? '', style: Get.textTheme.headline6?.copyWith(color: kErrorColor)).centered(),
        onLoading: CircularProgressIndicator().centered(),
      ),
      kSpacerY2,
    ]).py4;
  }
}
