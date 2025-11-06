import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/notification/notification_service.dart';
import 'package:navicare/core/providers/socket_provider.dart';
import 'package:navicare/core/routes/app_router.dart';
import 'package:navicare/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navicare/feature/therapy/presentation/pages/call_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  void _navigate(BuildContext context, WidgetRef ref, AuthState state) {
    final router = ref.read(routerProvider);
    final pendingRoute = ref.read(pendingRouteProvider);

    print("pendingRoute: $pendingRoute");
    state.when(
      initial: () {}, // Wait for the notifier's _checkAuthStatus
      loading: () {}, // Still resolving auth
      authenticated: (user) async {
        final userStatus = user.status;
        print("userStatus: ${userStatus}");
        print("user hours: ${user.hoursDedicatedPerWeek}");
        print("pendingRoute: ${pendingRoute}");
        // Decide where to go based on user data
        try {
          final socketService = ref.read(socketServiceProvider);
          await socketService.connect();
          print("Socket connected after login");
        } catch (e) {
          print("Socket connection error: $e");
          // Don't block navigation if socket fails
        }
        if (user.hoursDedicatedPerWeek != null &&
            user.hoursDedicatedPerWeek == 0) {
          // If hoursDedicatedPerWeek is not set, navigate to questionnaire
          router.go('/questionnaire');
        } else if (userStatus != "active") {
          router.go("/blocked-user");
        } else if (pendingRoute != null) {
          // Navigate to the pending route
          // Navigate to the pending route
          router.go("/main");
          router.push(pendingRoute.path, extra: pendingRoute.extra);
          ref.read(pendingRouteProvider.notifier).state = null;
        } else {
          router.go('/main');
        }
      },
      unauthenticated: () {
        ref.read(routerProvider).go('/login');
      },
      error: (_) {
        // On error, you can choose to show an error UI here or send to login
        ref.read(routerProvider).go('/login');
      },
      unverified: (_) {
        // If you have a verification flow, navigate there
        // router.go('/verify');
        ref.read(routerProvider).go('/login');
      },
      profileError: (user, message) {
        // Show a snackbar with the error message
        // NotificationService.showSnackBar(
        //   context,
        //   'Profile update failed: $message',
        // );
        // // Navigate to main or stay on the same page
        // ref.read(routerProvider).go('/main');
      },
    );
  }

  // void _navigateToCallScreen(
  //   BuildContext context,
  //   WidgetRef ref,
  //   Map<String, dynamic> callData,
  // ) {
  //   final roomName = callData['roomName'] as String;
  //   final participantName = callData['participantName'] as String;
  //   final chatId = callData['chatId'] as String;
  //   final isVideoCall = callData['isVideoCall'] as bool;

  //   ref.read(pendingRouteProvider.notifier).state = null;

  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder:
  //           (context) => CallScreen(
  //             roomName: roomName,
  //             participantName: participantName,
  //             isVideoCall: isVideoCall,
  //             chatId: chatId,
  //           ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    // Trigger navigation in an effect to avoid calling router during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate(context, ref, state);
    });

    // Neutral splash/loading UI
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
