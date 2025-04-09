import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interview_app/atomic/atoms/svg-icon/svg_icon_model.dart';

class SvgIcon extends StatelessWidget implements SvgIconModel {
  @override
  final String name;
  @override
  final double size;
  @override
  final Color? color;

  const SvgIcon({super.key, required this.name, this.size = 20.0, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      name,
      width: size,
      height: size,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
