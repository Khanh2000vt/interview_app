import 'package:flutter/material.dart';

abstract class GestureDetectorModel {
  abstract final void Function()? onTap;
  abstract final double? padding;
  abstract final Widget? child;
}
