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
    final Color primaryAccent = accentColor ?? AppTheme.primaryColor; // Cyan
    final Color secondaryAccent = AppTheme.secondaryColor; // Magenta
    final Color tertiaryAccent = AppTheme.accentOrange; // Orange

    return Stack(
      children: [
        // 1. Base solid/gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [
                      const Color(0xFF001A1F), // Slightly lighter teal top
                      const Color(0xFF000506), // Deep black bottom
                    ]
                  : [
                      const Color(0xFFFFFFFF),
                      const Color(0xFFE0F2F1),
                    ],
            ),
          ),
        ),

        // 2. Sophisticated Top-Left Cyan Glow
        Positioned(
          top: -200,
          left: -100,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  primaryAccent.withValues(alpha: isDarkMode ? 0.18 : 0.12),
                  primaryAccent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        // 3. Vibrant Bottom-Right Magenta Glow
        Positioned(
          bottom: -150,
          right: -100,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  secondaryAccent.withValues(alpha: isDarkMode ? 0.15 : 0.1),
                  secondaryAccent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        // 4. Subtle Orange Center-Left Glow (New additive layer)
        Positioned(
          top: MediaQuery.of(context).size.height * 0.3,
          left: -200,
          child: Container(
            width: 450,
            height: 450,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  tertiaryAccent.withValues(alpha: isDarkMode ? 0.1 : 0.06),
                  tertiaryAccent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),

        // 5. Overall ambient atmospheric blur
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            color: Colors.transparent,
          ),
        ),

        // 6. Subtle Noise/Texture overlay (Optional but adds "premium" feel)
        Opacity(
          opacity: 0.015,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.transparenttextures.com/patterns/stardust.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
