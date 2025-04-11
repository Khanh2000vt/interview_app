import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_app/atomic/screens/auth/config/widgets/config_screen.dart';
import 'package:interview_app/atomic/screens/main/chat_detail/chat_detail_screen.dart';
import 'package:interview_app/atomic/screens/main/home/widgets/home_screen.dart';
import 'package:interview_app/atomic/screens/main/list_chat/list_chat_screen.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';
import 'package:interview_app/routing/routes.dart';

final ValueNotifier<InterviewState> interviewStateNotifier = ValueNotifier(
  InterviewInitial(),
);

final GoRouter router = GoRouter(
  initialLocation: Routes.listChat,
  refreshListenable: interviewStateNotifier,
  routes: [
    GoRoute(
      path: Routes.listChat,
      builder: (context, state) {
        return ListChatScreen();
      },
    ),
    GoRoute(
      path: Routes.chatDetail,
      builder: (context, state) {
        return ChatDetailScreen();
      },
    ),
  ],
);
