import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_button.dart';
import 'package:flutter_restaurant/components/custom/custom_container.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/pages/access/access_controller.dart';
import 'package:flutter_restaurant/pages/access/user_login_view.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:vertical_tab_bar_view/vertical_tab_bar_view.dart';
import 'restaurant_login_view.dart';
export 'access_controller.dart';

class AccessPage extends GetView<AccessController> {
  const AccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.max, children: [
        FlutterLogo(size: Get.height / 6).p5.centered(),
        kSpacerY,
        TabBar(
          controller: controller.tabController,
          labelColor: Colors.white,
          unselectedLabelColor: kSecondaryColor,
          indicator: tabIndicator(kSecondaryColor),
          indicatorPadding: kPadding,
          tabs: [
            Tab(text: "Usuario", icon: Icon(UniconsLine.user_circle), iconMargin: EdgeInsets.zero),
            Tab(text: "Restaurante", icon: Icon(UniconsLine.restaurant), iconMargin: EdgeInsets.zero),
          ],
        ).px5,
        CustomContainer(
          body: VerticalTabBarView(
            controller: controller.tabController,
            physics: kBouncyScroll,
            children: [
              const UserLogInView(),
              const RestaurantLogInView(),
            ],
          ),
          footer: Obx(() => CustomButton.elevated(
                key: controller.buttonStatus,
                child: Text('Ingresar', textAlign: TextAlign.center).expanded(),
                prefix: Icon(UniconsLine.signin),
                onPressed: controller.tabIndex.value == 1 && controller.selectedRestaurantIndex.value == -1
                    ? null
                    : () {
                        controller.tabIndex.value == 0 ? controller.userLogIn() : controller.restaurantLogIn();
                      },
              ).height(50)).px5.px5,
        ).pLTRB(4, 2, 4, 4).expanded(),
      ]),
    ).safeArea();
  }
}
