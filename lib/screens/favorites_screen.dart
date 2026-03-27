import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../widgets/music_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

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
        title: const Text('Liked Songs'),
      ),
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          if (musicProvider.favoriteSongs.isEmpty) {
            return const Center(
              child: Text(
                'No liked songs yet',
                style: TextStyle(color: Color(0xFFB3B3B3)),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: musicProvider.favoriteSongs.length,
            itemBuilder: (context, index) {
              final song = musicProvider.favoriteSongs[index];
              return MusicCard(
                title: song.title,
                subtitle: song.artist,
                imageUrl: song.albumArt,
                onTap: () {
                  musicProvider.playSong(song);
                  Navigator.pushNamed(context, '/player');
                },
                trailing: IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Color(0xFF1DB954),
                  ),
                  onPressed: () => musicProvider.toggleFavorite(song),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
