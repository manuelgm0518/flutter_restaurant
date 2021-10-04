import 'package:flutter/material.dart';
import 'package:flutter_restaurant/components/custom/custom_button.dart';
import 'package:flutter_restaurant/components/custom/custom_text_field.dart';
import 'package:flutter_restaurant/components/food_types/food_type_selector.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:flutter_restaurant/providers/restaurants_provider.dart';
import 'package:flutter_restaurant/utils/printer.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:flutter_restaurant/utils/validator.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class RestaurantEditor extends StatefulWidget {
  RestaurantEditor._({Key? key, this.restaurant}) : super(key: key);
  final Restaurant? restaurant;

  static Future<Restaurant?> show([Restaurant? restaurant]) async {
    return await Get.bottomSheet(
      RestaurantEditor._(restaurant: restaurant),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(kBorderRadius))),
    );
  }

  @override
  _RestaurantEditorState createState() => _RestaurantEditorState();
}

class _RestaurantEditorState extends State<RestaurantEditor> {
  final formKey = GlobalKey<FormState>();
  final nameField = TextEditingController();
  final descriptionField = TextEditingController();
  final foodTypesKey = GlobalKey<FoodTypeSelectorState>();
  final statusButtonKey = GlobalKey<CustomButtonState>();
  final selectedFoodTypes = <String>{};

  bool get create => widget.restaurant == null;

  void save() {
    statusButtonKey.currentState?.setStatus(CustomButtonStatus.LOADING);
    final restaurant = new Restaurant(
      name: nameField.text,
      description: descriptionField.text,
      food_type: foodTypesKey.currentState?.selectedTypes ?? {},
    );
    (create
            ? RestaurantsProvider.to.postRestaurant(restaurant)
            : RestaurantsProvider.to.patchRestaurant(
                widget.restaurant!.slug!,
                restaurant.toMap()..remove('logo'),
              ))
        .then((value) {
      Get.back(result: value.body);
    }, onError: (error) {
      Printer.error(error);
      statusButtonKey.currentState?.setStatus(CustomButtonStatus.IDLE);
    });
  }

  @override
  void initState() {
    if (!create) {
      nameField.value = TextEditingValue(text: widget.restaurant!.name);
      descriptionField.value = TextEditingValue(text: widget.restaurant!.description);
      selectedFoodTypes.assignAll(widget.restaurant!.food_type);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
        Container(width: 80, height: 5, color: kLightColor).rounded().py3.centered(),
        kSpacerY,
        Text(create ? 'Regisitra tu restaurante' : 'Edita tu Restaurante', style: Get.textTheme.headline4?.copyWith(color: Colors.black)).px5,
        kSpacerY,
        CustomTextField(
          label: 'Nombre del restaurante',
          prefix: Icon(UniconsLine.restaurant),
          controller: nameField,
          validator: Validator.requiredField,
        ).px5,
        kSpacerY,
        CustomTextField(
          label: 'Descripción',
          prefix: Icon(UniconsLine.paragraph),
          controller: descriptionField,
          validator: Validator.requiredField,
        ).px5,
        kSpacerY4,
        Text('Tipos de comida', style: Get.textTheme.headline6?.copyWith(color: Colors.black)).px5,
        kSpacerY3,
        FoodTypeSelector(
          key: foodTypesKey,
          selectedTypes: selectedFoodTypes,
        ).width(Get.width * 1.5).scrollable(direction: Axis.horizontal, padding: kPaddingX5),
        kSpacerY3,
        kDivider.pxy(5, 3),
        CustomButton.elevated(
          key: statusButtonKey,
          child: Text('Guardar'),
          prefix: Icon(UniconsLine.save),
          onPressed: () => save(),
        ).px5,
      ]).py4.keyboardScroll(),
    );
  }
}
