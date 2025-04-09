import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_app/atomic/screens/auth/login/widgets/login_screen.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';
import 'package:interview_app/routing/routes.dart';

final ValueNotifier<InterviewState> interviewStateNotifier = ValueNotifier(
  InterviewInitial(),
);

final GoRouter router = GoRouter(
  initialLocation: Routes.login,
  refreshListenable: interviewStateNotifier,
  redirect: (context, state) async {
    final interviewBloc = context.read<InterviewBloc>();
    final interviewState = interviewBloc.state;
    final currentPath = state.uri.toString();

    switch (interviewState) {
      case InterviewInitial():
        if (currentPath == Routes.login) {
          return Routes.home;
        }
      case ConfigInterview():
        if (currentPath == Routes.home) {
          return Routes.login;
        }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreens();
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return LoginScreens();
      },
    ),
  ],
);
