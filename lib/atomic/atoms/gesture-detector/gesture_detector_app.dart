import 'package:flutter/material.dart';
import 'package:interview_app/atomic/atoms/gesture-detector/gesture_detector_model.dart';

class GestureDetectorApp extends StatelessWidget
    implements GestureDetectorModel {
  @override
  final Widget? child;

  @override
  final void Function()? onTap;

  @override
  final double? padding;

  const GestureDetectorApp({super.key, this.onTap, this.padding, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(padding: EdgeInsets.all(padding ?? 12.0), child: child),
    );
  }
}
