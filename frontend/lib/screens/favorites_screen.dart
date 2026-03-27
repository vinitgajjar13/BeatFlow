import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 240,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Liked Songs',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1496293455970-f8581aae0e3c?q=80&w=500&auto=format&fit=crop',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppTheme.darkBackground.withOpacity(0.8),
                              AppTheme.darkBackground,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        '${musicProvider.favoriteSongs.length} songs',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        backgroundColor: AppTheme.primaryColor,
                        radius: 24,
                        child: Icon(Icons.play_arrow, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              if (musicProvider.favoriteSongs.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No liked songs yet',
                      style: TextStyle(color: Color(0xFFB3B3B3)),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final song = musicProvider.favoriteSongs[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            song.albumArt,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          song.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(song.artist),
                        trailing: IconButton(
                          icon: const Icon(Icons.favorite, color: AppTheme.primaryColor),
                          onPressed: () => musicProvider.toggleFavorite(song),
                        ),
                        onTap: () {
                          musicProvider.playSong(song);
                          Navigator.pushNamed(context, '/player');
                        },
                      );
                    },
                    childCount: musicProvider.favoriteSongs.length,
                  ),
                ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          );
        },
      ),
    );
  }
}
