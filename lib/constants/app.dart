import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:interview_app/themes/scale.dart';
import 'package:responsive_framework/responsive_framework.dart';

final class AppConstants {
  final List<Breakpoint> breakpoints = [
    Breakpoint(start: 0, end: 450, name: MOBILE),
    Breakpoint(start: 451, end: 800, name: TABLET),
    Breakpoint(start: 801, end: 1920, name: DESKTOP),
    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
  ];
  final double heightElement = scaleH(55);
  final String keyGemini = dotenv.env['GEMINI_KEY'] ?? '';
  final String baseUrlGemini = dotenv.env['GEMINI_BASE_URL'] ?? '';
}
