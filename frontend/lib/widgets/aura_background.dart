import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AuraBackground extends StatelessWidget {
  final bool isDarkMode;
  final Color? accentColor;

  const AuraBackground({
    Key? key,
    required this.isDarkMode,
    this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color baseColor =
        isDarkMode ? const Color(0xFF080808) : const Color(0xFFFDFDFD);
    final Color primaryAccent = accentColor ?? AppTheme.primaryColor;
    final Color secondaryAccent = AppTheme.secondaryColor;

    return Stack(
      children: [
        // Base solid color
        Container(color: baseColor),

        // Deep accent glow top-left
        Positioned(
          top: -150,
          left: -150,
          child: Container(
            width: 450,
            height: 450,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryAccent.withValues(alpha: isDarkMode ? 0.15 : 0.1),
            ),
          ),
        ),

        // Vibrant accent glow bottom-right
        Positioned(
          bottom: -100,
          right: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: secondaryAccent.withValues(alpha: isDarkMode ? 0.12 : 0.08),
            ),
          ),
        ),

        // Center ambient glow
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  primaryAccent.withValues(alpha: isDarkMode ? 0.05 : 0.03),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // The blur layer that ties it all together
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
