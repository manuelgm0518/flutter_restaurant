import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_text_field.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:flutter_restaurant/utils/validator.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'access_controller.dart';

class UserLogInView extends GetView<AccessController> {
  const UserLogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
      Text('Ingresa como Usuario', style: Get.textTheme.headline4?.copyWith(color: Colors.black)).px4,
      Text('Encuentra tu restaurante favorito y recomiéndalo con una reseña!', style: Get.textTheme.bodyText2?.copyWith(color: Colors.black)).px4,
      kDivider.pxy(4, 3),
      Form(
        key: controller.userForm,
        child: CustomTextField(
          label: 'Correo electrónico',
          prefix: Icon(UniconsLine.envelope),
          keyboardType: TextInputType.emailAddress,
          validator: Validator.emailField,
          controller: controller.userEmailField,
        ),
      ).pxy(4, 1),
    ]).py4.keyboardScroll(kPaddingB5);
  }
}
