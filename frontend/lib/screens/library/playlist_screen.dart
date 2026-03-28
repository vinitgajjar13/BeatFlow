import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/music_provider.dart';
import '../../widgets/music_card.dart';

class PlaylistScreen extends StatelessWidget {
  final dynamic playlist;

  const PlaylistScreen({Key? key, this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Playlist'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Playlist Header
            if (playlist != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  playlist.coverImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playlist.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      playlist.description,
                      style: const TextStyle(
                        color: Color(0xFFB3B3B3),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${playlist.songCount} songs • ${playlist.totalDuration.inHours}h ${playlist.totalDuration.inMinutes % 60}m',
                      style: const TextStyle(
                        color: Color(0xFF1DB954),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Playlist not found',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            // Songs List
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Songs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (playlist != null && playlist.songs.isNotEmpty)
              ...playlist.songs
                  .map<Widget>(
                    (song) => MusicCard(
                      title: song.title,
                      subtitle: song.artist,
                      imageUrl: song.albumArt,
                      onTap: () {
                        Provider.of<MusicProvider>(context, listen: false)
                            .playSong(song);
                        Navigator.pushNamed(context, '/player');
                      },
                    ),
                  )
                  .toList(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

