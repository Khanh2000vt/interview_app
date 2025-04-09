import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:interview_app/atomic/atoms/button/button_app.dart';
import 'package:interview_app/atomic/atoms/button/button_app_model.dart';
import 'package:interview_app/atomic/organisms/organisms.dart';
import 'package:interview_app/enums/common.dart';
import 'package:interview_app/models/form_model.dart';
import 'package:interview_app/themes/scale.dart';

class LoginScreens extends StatelessWidget {
  const LoginScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final formFields = FormAppModel([
      InputFieldModel(
        name: 'email',
        labelText: 'Email',
        validators: [
          FormBuilderValidators.required(errorText: 'Vui lòng nhập email'),
          FormBuilderValidators.email(errorText: 'Email không hợp lệ'),
        ],
      ),
      InputFieldModel(
        name: 'password',
        labelText: 'Password',
        inputPassword: true,
        validators: [
          FormBuilderValidators.required(errorText: 'Vui lòng nhập password'),
          FormBuilderValidators.password(minLength: 6),
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
        appBar: AppBar(title: const Text('Login')),
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
                    children: [FormApp(formFields, formKey: _formKey)],
                  ),
                ),
                ButtonApp(
                  model: ButtonAppModel(
                    text: 'Login',
                    type: EButtonType.tonal,
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final formData = _formKey.currentState!.value;
                        print('Form data: $formData');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đăng nhập thành công!'),
                          ),
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
