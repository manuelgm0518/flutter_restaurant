import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_button.dart';
import 'package:flutter_restaurant/pages/home/home_controller.dart';
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
        CustomButton.elevated(child: Text('el pepe')),
        CustomButton.elevated(child: Text('el pepe'), onPressed: () {}),
        CustomButton.flatCircle(child: Icon(UniconsLine.align_center_v)),
        CustomButton.flatCircle(child: Icon(UniconsLine.align_center_v), onPressed: () {}),
        CustomButton.outlineCircle(child: Icon(UniconsLine.align_center_v)),
        CustomButton.outlineCircle(child: Icon(UniconsLine.align_center_v), onPressed: () {}),
      ]),
    );
  }
}
