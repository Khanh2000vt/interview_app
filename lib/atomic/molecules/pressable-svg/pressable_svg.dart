import 'package:flutter/material.dart';
import 'package:interview_app/atomic/atoms/gesture-detector/gesture_detector_app.dart';
import 'package:interview_app/atomic/atoms/gesture-detector/gesture_detector_model.dart';
import 'package:interview_app/atomic/atoms/svg-icon/svg_icon.dart';
import 'package:interview_app/atomic/atoms/svg-icon/svg_icon_model.dart';

class PressableSvg extends StatelessWidget
    implements GestureDetectorModel, SvgIconModel {
  @override
  final Color? color;

  @override
  final String name;

  @override
  final void Function()? onTap;

  @override
  final double? padding;

  @override
  final double size;
  @override
  final Widget? child = null;

  const PressableSvg({
    super.key,
    this.color,
    required this.name,
    this.onTap,
    this.padding,
    this.size = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetectorApp(
      onTap: onTap,
      padding: padding,
      child: SvgIcon(name: name, color: color, size: size),
    );
  }
}
