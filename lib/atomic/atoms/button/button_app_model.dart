import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_app/enums/common.dart';
import 'package:interview_app/themes/colors.dart';
import 'package:interview_app/themes/scale.dart';
import 'package:interview_app/typedef/button.dart';

class ButtonAppModel {
  final String text;
  final EButtonType type;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool loading;
  final bool enabled;
  final bool infinity;

  ButtonAppModel({
    required this.text,
    this.type = EButtonType.filled,
    this.onPressed,
    this.icon,
    this.foregroundColor,
    this.backgroundColor,
    this.loading = false,
    this.enabled = true,
    this.infinity = true,
  });

  double? get widthButton {
    return infinity ? double.infinity : null;
  }

  final ButtonStyleForm defaultStyle = (
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    getSideOutline: (isEnabled) {
      return BorderSide(color: isEnabled ? ColorsApp.primary : ColorsApp.gray2);
    },
  );

  Widget get child {
    return loading
        ? SizedBox(
          width: scaleW(20),
          height: scaleH(20),
          child: CupertinoActivityIndicator(color: Colors.white),
        )
        : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              SizedBox(width: scaleW(8)),
            ],
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        );
  }

  VoidCallback? get onPress {
    return enabled
        ? () {
          if (loading) {
            return;
          }
          onPressed!();
        }
        : null;
  }

  Widget getWidgetButton() {
    switch (type) {
      case EButtonType.filled:
        return FilledButton(
          onPressed: onPress,
          style: FilledButton.styleFrom(
            padding: defaultStyle.padding,
            shape: defaultStyle.shape,
          ),
          child: child,
        );
      case EButtonType.tonal:
        return FilledButton.tonal(
          onPressed: onPress,
          style: FilledButton.styleFrom(
            backgroundColor: ColorsApp.secondary,
            foregroundColor: ColorsApp.primary,
            padding: defaultStyle.padding,
            shape: defaultStyle.shape,
          ),
          child: child,
        );
      case EButtonType.outlined:
        return OutlinedButton(
          onPressed: onPress,
          style: FilledButton.styleFrom(
            padding: defaultStyle.padding,
            shape: defaultStyle.shape,
            side: defaultStyle.getSideOutline(enabled),
          ),
          child: child,
        );
      case EButtonType.text:
        return TextButton(
          onPressed: onPress,
          style: FilledButton.styleFrom(
            padding: defaultStyle.padding,
            shape: defaultStyle.shape,
          ),
          child: child,
        );
      default:
        return ElevatedButton(
          onPressed: onPress,
          style: FilledButton.styleFrom(
            padding: defaultStyle.padding,
            shape: defaultStyle.shape,
          ),
          child: child,
        );
    }
  }
}
