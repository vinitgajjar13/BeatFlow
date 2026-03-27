import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/play_button.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer2<MusicProvider, PlayerProvider>(
        builder: (context, musicProvider, playerProvider, _) {
          final song = musicProvider.currentSong;

          if (song == null) {
            return const Center(
              child: Text(
                'No song selected',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      song.albumArt,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        song.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${playerProvider.currentPosition.inMinutes}:${(playerProvider.currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: Color(0xFFB3B3B3),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${playerProvider.totalDuration.inMinutes}:${(playerProvider.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: Color(0xFFB3B3B3),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          value: playerProvider.totalDuration.inSeconds > 0
                              ? playerProvider.currentPosition.inSeconds /
                                  playerProvider.totalDuration.inSeconds
                              : 0,
                          backgroundColor: const Color(0xFF404040),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF1DB954),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Color(0xFF1DB954)),
                      iconSize: 28,
                      onPressed: () {
                        musicProvider.toggleFavorite(song);
                      },
                    ),
                    const SizedBox(width: 24),
                    PlayButton(
                      onPressed: () => musicProvider.togglePlayPause(),
                      isPlaying: musicProvider.isPlaying,
                      color: const Color(0xFF1DB954),
                    ),
                    const SizedBox(width: 24),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      iconSize: 28,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
