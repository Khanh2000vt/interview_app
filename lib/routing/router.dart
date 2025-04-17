import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview_app/atomic/screens/main/chat_detail/chat_detail_screen.dart';
import 'package:interview_app/atomic/screens/main/create-chanel/create_chanel_screen.dart';
import 'package:interview_app/atomic/screens/main/list_chat/list_chat_screen.dart';
import 'package:interview_app/bloc/interview/interview_bloc.dart';
import 'package:interview_app/routing/routes.dart';

final ValueNotifier<InterviewState> interviewStateNotifier = ValueNotifier(
  InterviewInitial(),
);

final GoRouter router = GoRouter(
  initialLocation: Routes.createChanel,
  refreshListenable: interviewStateNotifier,
  routes: [
    GoRoute(
      path: Routes.createChanel,
      builder: (context, state) {
        return CreateChanelScreen();
      },
    ),
    GoRoute(
      path: Routes.listChat,
      builder: (context, state) {
        return ListChatScreen();
      },
    ),
    GoRoute(
      path: '${Routes.chatDetail}/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ChatDetailScreen(id: id);
      },
    ),
  ],
);
