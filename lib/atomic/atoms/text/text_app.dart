import 'package:flutter/material.dart';
import 'package:interview_app/themes/scale.dart';

class TextApp extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool useScreenUtil;
  final String? fontFamily;
  final TextStyle? style;

  const TextApp(
    this.text, {
    super.key,
    this.fontSize = 13,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.useScreenUtil = false,
    this.fontFamily,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: useScreenUtil ? scaleSP(fontSize ?? 13) : fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
      fontFamily: fontFamily,
    );

    final textStyle = defaultStyle.merge(style);

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
