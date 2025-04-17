import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:interview_app/atomic/molecules/input/input_app.dart';
import 'package:interview_app/atomic/molecules/switch/switch_app.dart';
import 'package:interview_app/atomic/organisms/form-field/form_app_model.dart';
import 'package:interview_app/models/form_model.dart';
import 'package:interview_app/themes/scale.dart';

class FormApp extends StatelessWidget {
  final FormAppModel formFields;
  final GlobalKey<FormBuilderState> formKey;

  const FormApp(this.formFields, {super.key, required this.formKey});

  Widget? _buildFormField(FormFieldModel field) {
    switch (field) {
      case InputFieldModel():
        return InputApp(field);
      case SwitchFieldModel():
        return SwitchAppField(field);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: scaleH(16),
          children: [
            ...formFields.formFields.map(
              (field) => Padding(
                padding: EdgeInsets.zero,
                child: _buildFormField(field),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
