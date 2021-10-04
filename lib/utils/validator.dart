import 'package:get/get.dart';

extension StringExtension on String {
  bool get isSlug => this.isNotEmpty && RegExp(r'^[-a-zA-Z0-9_]+$').hasMatch(this);
}

class Validator {
  static String? requiredField(String? value) => (value?.isEmpty ?? true) ? 'Este campo es requerido' : null;

  static String? slugField(String? value) => requiredField(value) ?? (!value!.isSlug ? 'Formato incorrecto' : null);

  static String? emailField(String? value) => requiredField(value) ?? (!value!.isEmail ? 'Correo no válido' : null);
}
