import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/music_provider.dart';
import '../../core/theme/app_theme.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    // Start rotation if already playing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<MusicProvider>(context, listen: false).isPlaying) {
        _rotationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _handlePlayPause(MusicProvider musicProvider) {
    HapticFeedback.mediumImpact();
    musicProvider.togglePlayPause();
    if (musicProvider.isPlaying) {
      _rotationController.repeat();
    } else {
      _rotationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, _) {
        final song = musicProvider.currentSong;

        if (song == null) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child: Text('No song selected',
                    style: TextStyle(color: Colors.white))),
          );
        }

        // Sync rotation controller with playing state
        if (musicProvider.isPlaying && !_rotationController.isAnimating) {
          _rotationController.repeat();
        } else if (!musicProvider.isPlaying &&
            _rotationController.isAnimating) {
          _rotationController.stop();
        }

        final double screenWidth = MediaQuery.sizeOf(context).width;
        final double albumArtSize = screenWidth * 0.75;

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 36, color: Colors.white),
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_rounded,
                    color: Colors.white, size: 24),
                onPressed: () => HapticFeedback.lightImpact(),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Ambient Background Blur
              Positioned.fill(
                child: Hero(
                  tag: 'album-bg-${song.id}',
                  child: CachedNetworkImage(
                    imageUrl: song.albumArt,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  child: Container(color: Colors.black.withValues(alpha: 0.6)),
                ),
              ),

              // Main Content
              SafeArea(
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // Vinyl Record Animation
                    Center(
                      child: Hero(
                        tag: 'album-${song.id}',
                        child: RotationTransition(
                          turns: _rotationController,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer Glow
                              Container(
                                width: albumArtSize + 10,
                                height: albumArtSize + 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryColor
                                          .withValues(alpha: 0.2),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                              // Vinyl Disk
                              Container(
                                width: albumArtSize,
                                height: albumArtSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF1A1A1A),
                                  border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.1),
                                      width: 2),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        song.albumArt),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Center Hole
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                      width: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate(key: ValueKey(song.id)).scale(
                          duration: 600.ms,
                          curve: Curves.elasticOut,
                          begin: const Offset(0.8, 0.8),
                        ),

                    const Spacer(flex: 2),

                    // Glassy Bottom Sheet
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(38),
                        border: Border.all(
                            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                            width: 1.5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Column(
                            children: [
                              // Song Info
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          song.title,
                                          style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            letterSpacing: -0.5,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          song.artist,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                                .withValues(alpha: 0.6),
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      musicProvider.favoriteSongs.contains(song)
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      color: musicProvider.favoriteSongs
                                              .contains(song)
                                          ? Theme.of(context).colorScheme.secondary // Magenta
                                        : Colors.white,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      HapticFeedback.mediumImpact();
                                      musicProvider.toggleFavorite(song);
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Progress Bar
                              Column(
                                children: [
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: AppTheme.primaryColor,
                                      inactiveTrackColor:
                                          Colors.white.withValues(alpha: 0.1),
                                      thumbColor: Colors.white,
                                      trackHeight: 4,
                                      thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 6),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                              overlayRadius: 14),
                                    ),
                                    child: Slider(
                                      value: musicProvider
                                          .currentPosition.inSeconds
                                          .toDouble(),
                                      max: song.duration.inSeconds.toDouble(),
                                      onChanged: (value) {
                                        // Mock seek
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildTimeText(
                                            musicProvider.currentPosition),
                                        _buildTimeText(song.duration),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Controls
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.shuffle_rounded),
                                    color: Colors.white.withValues(alpha: 0.4),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                        Icons.skip_previous_rounded,
                                        color: Colors.white),
                                    iconSize: 48,
                                    onPressed: () {
                                      HapticFeedback.lightImpact();
                                      musicProvider.previousSong();
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        _handlePlayPause(musicProvider),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).primaryColor
                                                .withValues(alpha: 0.4),
                                            blurRadius: 30,
                                            spreadRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        musicProvider.isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: Colors.black,
                                        size: 42,
                                      ),
                                    )
                                        .animate(
                                            target:
                                                musicProvider.isPlaying ? 1 : 0)
                                        .shimmer(
                                            duration: 2.seconds,
                                            color: AppTheme.primaryColor
                                                .withValues(alpha: 0.3))
                                        .scale(
                                            begin: const Offset(1, 1),
                                            end: const Offset(1.05, 1.05),
                                            duration: 200.ms),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.skip_next_rounded,
                                        color: Colors.white),
                                    iconSize: 48,
                                    onPressed: () {
                                      HapticFeedback.lightImpact();
                                      musicProvider.nextSong();
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.repeat_rounded),
                                    color: Colors.white.withValues(alpha: 0.4),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 600.ms)
                        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuart),

                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeText(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      "$minutes:$seconds",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white.withValues(alpha: 0.5),
      ),
    );
  }
}
