import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/music_provider.dart';
import '../providers/player_provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MusicProvider, PlayerProvider>(
      builder: (context, musicProvider, playerProvider, _) {
        final song = musicProvider.currentSong;

        if (song == null) {
          return const Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(child: Text('No song selected')),
          );
        }

        final double screenHeight = MediaQuery.sizeOf(context).height;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent, // Uses dynamic background from main.dart
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 36, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
                onPressed: () {},
              )
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Edge-to-edge background album art (override the main.dart ambient to be bold here)
              Hero(
                tag: 'album-${song.id}',
                child: CachedNetworkImage(
                  imageUrl: song.albumArt,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorWidget: (context, url, error) => const SizedBox(),
                ),
              ),
              // Gradient fade out at bottom to transition into glass
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                      stops: const [0.3, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
              
              // Glassy Bottom Sheet
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      height: screenHeight * 0.45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        border: Border(
                          top: BorderSide(color: Colors.white.withValues(alpha: 0.2), width: 1),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Capsule grabber
                          Container(
                            width: 48,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const Spacer(),
                          // Song Info
                          Column(
                            children: [
                              Text(
                                song.title,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).animate(key: ValueKey(song.title)).fadeIn(duration: 400.ms).slideY(begin: 0.3, end: 0),
                              const SizedBox(height: 8),
                              Text(
                                song.artist,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ).animate(key: ValueKey(song.artist)).fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: 0.3, end: 0),
                            ],
                          ),
                          const Spacer(),
                          // Progress Bar
                          Column(
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Colors.white,
                                  inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
                                  thumbColor: Colors.white,
                                  trackHeight: 4,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                                ),
                                child: Slider(
                                  value: playerProvider.currentPosition.inSeconds.toDouble(),
                                  max: playerProvider.totalDuration.inSeconds.toDouble() > 0 ? playerProvider.totalDuration.inSeconds.toDouble() : 100,
                                  onChanged: (value) {
                                    // Implement seek
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${playerProvider.currentPosition.inMinutes}:${(playerProvider.currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.6), fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${playerProvider.totalDuration.inMinutes}:${(playerProvider.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.6), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
                          const Spacer(),
                          // Controls
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.shuffle_rounded),
                                color: Colors.white.withValues(alpha: 0.5),
                                iconSize: 28,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.skip_previous_rounded, color: Colors.white),
                                iconSize: 42,
                                onPressed: () => musicProvider.previousSong(),
                              ),
                              GestureDetector(
                                onTap: () => musicProvider.togglePlayPause(),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    musicProvider.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                    color: Colors.black,
                                    size: 48,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.skip_next_rounded, color: Colors.white),
                                iconSize: 42,
                                onPressed: () => musicProvider.nextSong(),
                              ),
                              IconButton(
                                icon: const Icon(Icons.repeat_rounded),
                                color: Colors.white.withValues(alpha: 0.5),
                                iconSize: 28,
                                onPressed: () {},
                              ),
                            ],
                          ).animate().fadeIn(duration: 400.ms, delay: 300.ms).slideY(begin: 0.2, end: 0),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ).animate().slideY(begin: 1.0, end: 0, duration: 500.ms, curve: Curves.easeOutCubic),
            ],
          ),
        );
      },
    );
  }
}
