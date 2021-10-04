import 'package:flutter/material.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator({Key? key, this.message}) : super(key: key);
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
      Lottie.asset('assets/animations/empty.json'),
      kSpacerY,
      Text(
        message ?? 'No se encontraron resultados',
        textAlign: TextAlign.center,
        style: Get.textTheme.headline6?.copyWith(color: kDarkColor),
      ),
    ]);
  }
}
