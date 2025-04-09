import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview_app/constants/app.dart';
import 'package:interview_app/routing/router.dart';
import 'package:interview_app/themes/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(428, 926),
      builder: (context, child) => MaterialMainApp(),
    );
  }
}

class MaterialMainApp extends StatelessWidget {
  const MaterialMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeApp().theme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      builder:
          (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: breakpoints,
          ),
    );
  }
}
