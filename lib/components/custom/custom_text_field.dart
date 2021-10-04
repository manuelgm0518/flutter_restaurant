import 'package:flutter/material.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:get/get.dart';
import 'package:derived_colors/derived_colors.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.controller,
    required this.label,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String label;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool focused = false;
  void _onFocusChange(bool value) {
    setState(() => focused = value);
  }

  Color get themePrimary => Get.theme.colorScheme.primary;
  Color get themeSecondary => Get.theme.colorScheme.secondary;
  Color get textColor => focused ? themePrimary : themeSecondary;
  Color get backgroundColor => focused ? themePrimary.variants.light : themeSecondary.variants.light;
  Widget? iconTheme(Widget? widget) => widget != null ? IconTheme(data: IconThemeData(color: textColor, size: 20), child: widget) : null;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Get.theme.copyWith(colorScheme: Get.theme.colorScheme.copyWith(primary: textColor)),
      child: FocusScope(
        onFocusChange: (value) => _onFocusChange(value),
        child: TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: Get.textTheme.bodyText2?.copyWith(color: Colors.black),
          decoration: InputDecoration(
            fillColor: backgroundColor,
            labelStyle: Get.textTheme.subtitle1?.copyWith(color: textColor),
            labelText: widget.label,
            prefixIcon: iconTheme(widget.prefix),
            suffixIcon: iconTheme(widget.suffix),
          ),
        ),
      ),
    );
  }
}
