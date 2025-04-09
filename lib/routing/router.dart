import 'package:go_router/go_router.dart';
import 'package:interview_app/atomic/screens/auth/login/widgets/login_screen.dart';
import 'package:interview_app/routing/routes.dart';

// final ValueNotifier<AuthState> authStateNotifier = ValueNotifier(AuthInitial());

final GoRouter router = GoRouter(
  initialLocation: Routes.login,
  // refreshListenable: authStateNotifier,
  redirect: (context, state) async {
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreens();
      },
    ),
  ],
);
