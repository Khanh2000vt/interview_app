import 'package:flutter/material.dart';
import 'package:interview_app/atomic/atoms/button/button_app_model.dart';
import 'package:interview_app/constants/app.dart';

class ButtonApp extends StatelessWidget {
  final ButtonAppModel model;

  const ButtonApp({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightElement,
      width: model.widthButton,
      child: model.getWidgetButton(),
    );
  }
}
