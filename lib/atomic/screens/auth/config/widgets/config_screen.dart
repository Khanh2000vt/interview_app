import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:interview_app/atomic/atoms/button/button_app.dart';
import 'package:interview_app/atomic/atoms/button/button_app_model.dart';
import 'package:interview_app/atomic/organisms/organisms.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';
import 'package:interview_app/enums/common.dart';
import 'package:interview_app/models/form_model.dart';
import 'package:interview_app/themes/scale.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final formFields = FormAppModel([
      InputFieldModel(
        name: 'job',
        labelText: 'Công việc',
        validators: [
          FormBuilderValidators.required(errorText: 'Vui lòng công việc'),
        ],
      ),
      InputFieldModel(
        name: 'level',
        labelText: 'Kinh nghiệm',
        validators: [
          FormBuilderValidators.required(
            errorText: 'Vui lòng nhập kinh nghiệm',
          ),
        ],
      ),
    ]);

    void unfocusAll() {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    return GestureDetector(
      onTap: unfocusAll,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: const Text('Lựa chọn')),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: scaleW(16), right: scaleW(16)),
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [FormApp(formFields, formKey: formKey)],
                  ),
                ),
                ButtonApp(
                  model: ButtonAppModel(
                    text: 'Phỏng vấn',
                    type: EButtonType.tonal,
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final formData = formKey.currentState!.value;
                        context.read<InterviewBloc>().add(
                          ConfigSuccess(formData['job'], formData['level']),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vào phỏng vấn thôi!')),
                        );
                        return;
                      }
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Nhập!')));
                      // context.read<AuthBloc>().add(LoginSuccess('fake_token'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
