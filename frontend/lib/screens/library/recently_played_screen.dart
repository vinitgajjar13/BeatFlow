import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/music_provider.dart';
import '../../widgets/music_card.dart';

class RecentlyPlayedScreen extends StatelessWidget {
  const RecentlyPlayedScreen({Key? key}) : super(key: key);

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
        title: const Text('Recently Played'),
      ),
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: musicProvider.allSongs.length,
            itemBuilder: (context, index) {
              final song = musicProvider.allSongs[index];
              return MusicCard(
                title: song.title,
                subtitle: song.artist,
                imageUrl: song.albumArt,
                onTap: () {
                  musicProvider.playSong(song);
                  Navigator.pushNamed(context, '/player');
                },
              );
            },
          );
        },
      ),
    );
  }
}
