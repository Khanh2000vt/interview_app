import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:interview_app/models/form_model.dart';
import 'package:interview_app/themes/colors.dart';

class SwitchAppField extends StatelessWidget {
  final SwitchFieldModel model;
  const SwitchAppField(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    if (model.hide == true) {
      return const SizedBox.shrink();
    }
    return FormBuilderField(
      name: model.name,
      initialValue: model.initialValue,
      enabled: model.enabled,
      validator:
          model.validators != null
              ? FormBuilderValidators.compose(model.validators!)
              : null,
      builder: (FormFieldState<bool> field) {
        final bool valueField = field.value ?? model.initialValue ?? false;
        return SwitchApp(
          error: field.hasError,
          value: valueField,
          label: model.label ?? '',
          onChanged: (bool valueNew) {
            field.didChange(valueNew);
            if (valueNew != valueField) {
              model.onValueChanged?.call(valueNew);
            }
          },
        );
      },
    );
  }
}

class SwitchApp extends StatelessWidget {
  const SwitchApp({
    super.key,
    this.error = false,
    required this.value,
    required this.label,
    this.onChanged,
  });

  final bool? error;
  final bool value;
  final String label;
  final void Function(bool)? onChanged;

  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(<WidgetStatesConstraint, Icon>{
        WidgetState.selected: Icon(Icons.check),
        WidgetState.any: Icon(Icons.close),
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: error! ? ColorsApp.error : ColorsApp.text),
        ),
        Switch(thumbIcon: thumbIcon, value: value, onChanged: onChanged),
      ],
    );
  }
}
