import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:navicare/core/theme/app_colors.dart';
import 'package:livekit_client/livekit_client.dart';

class NoVideoWidget extends StatelessWidget {
  final Participant participant;

  const NoVideoWidget({super.key, required this.participant});

  @override
  Widget build(BuildContext context) {
    String name =
        participant.name.isNotEmpty ? participant.name : participant.identity;
    String initials =
        name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?';

    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, Color(0xFF0066FF)],
        ),
      ),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final size =
              math.min(constraints.maxHeight, constraints.maxWidth) * 0.3;
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.2,
              ), // Light translucent inner circle
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
