import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_app/atomic/screens/auth/config/widgets/config_screen.dart';
import 'package:interview_app/atomic/screens/main/home/widgets/home_screen.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';
import 'package:interview_app/routing/routes.dart';

final ValueNotifier<InterviewState> interviewStateNotifier = ValueNotifier(
  InterviewInitial(),
);

final GoRouter router = GoRouter(
  initialLocation: Routes.config,
  refreshListenable: interviewStateNotifier,
  redirect: (context, state) async {
    final interviewBloc = context.read<InterviewBloc>();
    final interviewState = interviewBloc.state;
    // final currentPath = state.uri.toString();

    switch (interviewState) {
      case InterviewInitial():
        return Routes.config;
      case ConfigInterview():
        return Routes.home;
      case Unauthenticated():
        return Routes.config;
    }
    // return null;
  },
  routes: [
    GoRoute(
      path: Routes.config,
      builder: (context, state) {
        return ConfigScreen();
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return HomeScreen();
      },
    ),
  ],
);
