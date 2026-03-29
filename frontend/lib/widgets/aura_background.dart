import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AuraBackground extends StatefulWidget {
  final Color? accentColor;
  final bool isDarkMode;

  const AuraBackground({
    Key? key,
    this.accentColor,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<AuraBackground> createState() => _AuraBackgroundState();
}

class _AuraBackgroundState extends State<AuraBackground> with TickerProviderStateMixin {
  late List<_BlobData> _blobs;
  late Timer _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _blobs = List.generate(3, (index) => _BlobData(_random));
    
    // Periodically update blob targets for organic movement
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted) {
        setState(() {
          for (var blob in _blobs) {
            blob.updateTarget(_random);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = widget.isDarkMode ? AppTheme.auraBaseDark : AppTheme.auraBaseLight;
    final Color blobColor = widget.accentColor ?? AppTheme.primaryColor;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Base Minimal Layer
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          color: baseColor,
        ),

        // Moving Aura Blobs
        ..._blobs.map((blob) {
          return AnimatedPositioned(
            duration: const Duration(seconds: 4),
            curve: Curves.easeInOutSine,
            top: blob.top * MediaQuery.of(context).size.height,
            left: blob.left * MediaQuery.of(context).size.width,
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              width: blob.size,
              height: blob.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    blobColor.withValues(alpha: widget.isDarkMode ? 0.15 : 0.1),
                    blobColor.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          );
        }).toList(),

        // Extra Smoothing Blur
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Container(color: Colors.transparent),
          ),
        ),

        // Readability Overlay (Subtle noise/dimmer)
        Container(
          decoration: BoxDecoration(
            color: widget.isDarkMode 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }
}

class _BlobData {
  late double top;
  late double left;
  late double size;

  _BlobData(Random random) {
    updateTarget(random);
    size = 400 + random.nextDouble() * 300;
  }

  void updateTarget(Random random) {
    top = random.nextDouble() * 1.2 - 0.2; // Allow slightly off-screen
    left = random.nextDouble() * 1.2 - 0.2;
  }
}
