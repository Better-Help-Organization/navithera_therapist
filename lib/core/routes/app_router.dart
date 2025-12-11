import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/widget/auth_gate.dart';
import 'package:navicare/core/widget/first_time_wrapper.dart';
import 'package:navicare/feature/audioplayer/presentation/pages/meditation_list_screen.dart';
import 'package:navicare/feature/auth/presentation/pages/blocked_user_screen.dart';
import 'package:navicare/feature/auth/presentation/pages/forgot_password_screen.dart';
import 'package:navicare/feature/auth/presentation/pages/login_screen.dart';
import 'package:navicare/feature/auth/presentation/pages/reset_password_screen.dart';
import 'package:navicare/feature/auth/presentation/pages/signup_screen.dart';
import 'package:navicare/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navicare/feature/chat/presentation/pages/message_screen.dart';
import 'package:navicare/feature/journal/presentation/pages/my_journal.dart';
import 'package:navicare/feature/navigation/presentation/pages/main_navigation.dart';
import 'package:navicare/feature/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:navicare/feature/questionnaire/presentation/pages/match_request_screen.dart';
import 'package:navicare/feature/questionnaire/presentation/pages/questionnaire_screen.dart';
import 'package:navicare/feature/questionnaire/presentation/pages/category_selection_screen.dart';
import 'package:navicare/feature/profile/presentation/pages/update_profile_screen.dart';
import 'package:navicare/feature/therapy/presentation/pages/user_list_screen.dart';
import 'package:navicare/feature/transaction/presentation/pages/transaction_screen.dart';
import 'package:navicare/main.dart'; // Add this import to access navigatorKey

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey, // Now this will work
    initialLocation: '/', // Set initial route to '/'
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        // Add this route as the initial route
        path: '/',
        builder: (context, state) => const FirstTimeWrapper(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: '/auth-gate',
        builder: (context, state) => const AuthGate(),
      ),
      GoRoute(
        path: '/questionnaire',
        builder: (context, state) => const PostSignupQuestionnaireScreen(),
      ),
      // GoRoute(path: '/', builder: (context, state) => OnBoardingScreen()),
      GoRoute(path: '/main', builder: (context, state) => MainNavigation()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => SignupPage()),
      GoRoute(
        path: '/updateProfile',
        builder: (context, state) {
          final index = state.extra as int? ?? 0; // default to 0 if not passed
          return UpdateProfileWrapperPage(initialIndex: index);
        },
      ),

      GoRoute(
        path: '/blocked-user',
        builder: (context, state) => BlockedUserScreen(),
      ),
      GoRoute(path: '/journal', builder: (context, state) => MyJournalScreen()),
      GoRoute(
        path: '/meditationList',
        builder: (context, state) => MeditationListScreen(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => CategorySelectionScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/transactions',
        builder: (context, state) => const TransactionScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) {
          // Get the email from query parameters or extra
          final email = state.extra as String?;
          if (email == null) {
            // Handle error case - redirect back or show error
            return Scaffold(
              body: Center(child: Text('Email is required for password reset')),
            );
          }
          return ResetPasswordScreen(email: email);
        },
      ),
      // GoRoute(
      //   path: '/questionnaire',
      //   builder: (context, state) => QuestionnaireScreen(),
      // ),
      GoRoute(path: '/clients', builder: (context, state) => UsersListScreen()),
      GoRoute(
        path: '/match-request',
        // name: 'match-request', // Add a name for easier navigation
        builder: (context, state) {
          final req = state.extra as MatchRequest?;
          if (req == null) {
            return const Scaffold(
              body: Center(child: Text('No match request data')),
            );
          }
          return MatchRequestScreen(request: req);
        },
      ),
      GoRoute(
        path: '/chat/:chatId',
        builder: (context, state) {
          // You'll need to get the chat object from somewhere
          // This could be from a provider or passed as extra
          final chat = state.extra as Chat?;
          if (chat == null) {
            // Handle error case where chat is not provided
            return const Scaffold(body: Center(child: Text('Chat not found')));
          }
          return ChatMessageScreen(chat: chat);
        },
      ),
      GoRoute(
        path: '/match-request',
        builder: (context, state) {
          final req = state.extra as MatchRequest?;
          if (req == null) {
            return const Scaffold(
              body: Center(child: Text('No match request data')),
            );
          }
          return MatchRequestScreen(request: req);
        },
      ),
    ],
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
});
