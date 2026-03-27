import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/artist_model.dart';
import '../providers/music_provider.dart';
import '../theme/app_theme.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;

  const ArtistDetailScreen({Key? key, required this.artist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                artist.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    artist.profileImage,
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
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Follow'),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.more_horiz),
                      const Spacer(),
                      const CircleAvatar(
                        backgroundColor: AppTheme.primaryColor,
                        radius: 28,
                        child: Icon(Icons.play_arrow, color: Colors.white, size: 32),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Popular Tracks',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Consumer<MusicProvider>(
            builder: (context, provider, _) {
              final artistSongs = provider.allSongs
                  .where((s) => s.artist == artist.name)
                  .toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final song = artistSongs[index];
                    return ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                      title: Text(
                        song.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${artist.followers ~/ 1000000}M monthly listeners'),
                      trailing: const Icon(Icons.more_vert),
                      onTap: () {
                        provider.playSong(song);
                        Navigator.pushNamed(context, '/player');
                      },
                    );
                  },
                  childCount: artistSongs.length,
                ),
              );
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'About the Artist',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${artist.name} is a global sensation known for their ${artist.genre} style. With over ${artist.followers ~/ 1000000} million followers, they continue to dominate the charts.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
