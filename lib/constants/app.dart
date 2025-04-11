import 'package:interview_app/themes/scale.dart';
import 'package:responsive_framework/responsive_framework.dart';

abstract final class AppConstants {
  static List<Breakpoint> breakpoints = [
    Breakpoint(start: 0, end: 450, name: MOBILE),
    Breakpoint(start: 451, end: 800, name: TABLET),
    Breakpoint(start: 801, end: 1920, name: DESKTOP),
    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
  ];
  static double heightElement = scaleH(55);
  static String baseUrlGemini =
      'https://generativelanguage.googleapis.com/v1beta/';
}
