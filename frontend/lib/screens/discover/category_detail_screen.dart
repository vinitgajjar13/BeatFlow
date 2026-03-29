import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/music_provider.dart';
import '../../core/theme/app_theme.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;

  const CategoryDetailScreen({
    Key? key,
    required this.categoryName,
    required this.categoryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: categoryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                categoryName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      categoryColor,
                      AppTheme.darkBackground,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(categoryName),
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Popular in $categoryName',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Consumer<MusicProvider>(
            builder: (context, provider, _) {
              // In a real app, we would filter by genre.
              // For now, let's just show some songs or all songs as a placeholder.
              final categorizedSongs = provider.allSongs;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final song = categorizedSongs[index];
                    return ListTile(
                      leading: SizedBox(
                        width: 48,
                        height: 48,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl: song.albumArt,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.withValues(alpha: 0.2),
                              child: const Icon(Icons.music_note_rounded,
                                  color: Colors.white24, size: 24),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        song.title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        song.artist,
                        style: TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12),
                      ),
                      trailing: const Icon(Icons.more_vert, color: Colors.grey),
                      onTap: () {
                        provider.playSong(song);
                        Navigator.pushNamed(context, '/player');
                      },
                    );
                  },
                  childCount: categorizedSongs.length,
                ),
              );
            },
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String name) {
    switch (name.toLowerCase()) {
      case 'pop':
        return Icons.face;
      case 'rock':
        return Icons.music_note;
      case 'hip-hop':
        return Icons.mic;
      case 'indie':
        return Icons.favorite;
      case 'electronic':
        return Icons.flash_on;
      case 'r&b':
        return Icons.waves;
      default:
        return Icons.music_note;
    }
  }
}
