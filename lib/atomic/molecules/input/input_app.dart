import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:interview_app/atomic/molecules/pressable-svg/pressable_svg.dart';
import 'package:interview_app/constants/svgs.dart';
import 'package:interview_app/models/form_model.dart';
import 'package:interview_app/themes/colors.dart';
import 'package:interview_app/themes/scale.dart';

class InputApp extends StatefulWidget {
  final InputFieldModel model;
  const InputApp(this.model, {super.key});

  @override
  State<InputApp> createState() => _InputAppState();
}

class _InputAppState extends State<InputApp> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        _obscureText = widget.model.inputPassword;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = _isFocused ? ColorsApp.primary : ColorsApp.gray1;
    final props = widget.model;

    Widget? suffixIcon() {
      if (props.inputPassword) {
        if (!_isFocused) {
          return null;
        }
        return PressableSvg(
          name: _obscureText ? SvgAssets.eyeOffStroke : SvgAssets.eyeStroke,
          color: iconColor,
          size: 20.0,
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        );
      }
      if (props.suffixIcon == null) {
        return null;
      }
      return PressableSvg(
        name: props.suffixIcon!,
        color: iconColor,
        size: 20.0,
      );
    }

    final decoration = InputDecoration(
      labelText: props.labelText,
      hintText: props.hintText,
      hintStyle: TextStyle(color: Colors.grey),
      prefixIcon:
          props.prefixIcon != null
              ? PressableSvg(
                name: props.prefixIcon!,
                color: iconColor,
                size: 20.0,
              )
              : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: ColorsApp.gray2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: ColorsApp.gray2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: ColorsApp.primary),
      ),
      suffixIcon: suffixIcon(),
    );

    final style = TextStyle(
      color: ColorsApp.text,
      fontWeight: FontWeight.w600,
      fontSize: scaleSP(14),
    );

    if (props.hide == true) {
      return const SizedBox.shrink();
    }

    return FormBuilderTextField(
      name: props.name,
      initialValue: props.initialValue,
      focusNode: _focusNode,
      decoration: decoration,
      obscureText: _obscureText,
      style: style,
      enabled: props.enabled,
      onChanged: (value) {
        setState(() {});
      },
      validator:
          props.validators != null
              ? FormBuilderValidators.compose(props.validators!)
              : null,
    );
  }
}
