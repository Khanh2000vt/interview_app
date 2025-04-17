import 'package:flutter/material.dart';

// validator: FormBuilderValidators.compose([
// FormBuilderValidators.required(errorText: 'Vui lòng nhập email'),
// FormBuilderValidators.email(errorText: 'Email không hợp lệ'),
// ]),

sealed class FormFieldModel<T> {
  String get name;
  T? get initialValue;
  bool get enabled;
  bool? get hide;
  List<FormFieldValidator<T>>? get validators => [];

  bool hasRequired() {
    if (validators == null || validators!.isEmpty) {
      return false;
    }
    return validators!.any(
      (validator) => (validator.toString().contains('required')),
    );
  }
}

class InputFieldModel extends FormFieldModel<String> {
  final String? prefixIcon;
  final String? suffixIcon;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool inputPassword;

  @override
  final bool enabled;
  @override
  final String name;
  @override
  final String? initialValue;
  @override
  final List<FormFieldValidator<String>>? validators;
  @override
  bool? hide;

  InputFieldModel({
    this.enabled = true,
    required this.name,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.validators,
    this.inputPassword = false,
    this.hide = false,
  });

  bool isInputPassword() {
    return keyboardType == TextInputType.visiblePassword;
  }

  dynamic getFormBuilder() {}
}

class SwitchFieldModel extends FormFieldModel<bool> {
  final String? label;
  final String? hint;
  final void Function(bool value)? onValueChanged;
  @override
  final bool? initialValue;
  @override
  final bool enabled;
  @override
  final String name;
  @override
  final List<FormFieldValidator<bool>>? validators;
  @override
  bool? hide;

  SwitchFieldModel({
    this.label,
    this.hint,
    this.onValueChanged,
    this.initialValue,
    this.enabled = true,
    required this.name,
    this.validators,
    this.hide = false,
  });
}
