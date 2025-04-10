import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';
import 'package:interview_app/constants/app.dart';
import 'package:interview_app/routing/router.dart';
import 'package:interview_app/themes/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  void _listenerInterview(context, state) {
    interviewStateNotifier.value = state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InterviewBloc(),
      child: BlocListener<InterviewBloc, InterviewState>(
        listener: _listenerInterview,
        child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: Size(428, 926),
          builder: (context, child) => MaterialMainApp(),
        ),
      ),
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
            breakpoints: AppConstants.breakpoints,
          ),
    );
  }
}
