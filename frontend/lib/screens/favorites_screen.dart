import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/music_provider.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Allow dynamic background
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 24),
                  title: const Text(
                    'Liked Songs',
                    style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 28),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),
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
                              Colors.black.withValues(alpha: 0.1),
                              Colors.black.withValues(alpha: 0.4),
                              Theme.of(context).cardColor,
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
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Row(
                    children: [
                      Text(
                        '${musicProvider.favoriteSongs.length} SONGS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      const Spacer(),
                      // Glassy Play Button
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withValues(alpha: 0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
                          ),
                        ),
                      ).animate().scale(delay: 300.ms, begin: const Offset(0, 0), end: const Offset(1, 1), curve: Curves.easeOutBack),
                    ],
                  ),
                ),
              ),
              if (musicProvider.favoriteSongs.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No liked songs yet',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.5),
                          ),
                    ).animate().fadeIn(),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final song = musicProvider.favoriteSongs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ClipRRect(
                            borderRadius: AppTheme.geometry,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardTheme.color,
                                  borderRadius: AppTheme.geometry,
                                  border: Border.all(color: Theme.of(context).dividerColor),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  leading: ClipRRect(
                                    borderRadius: AppTheme.geometry / 2,
                                    child: Image.network(
                                      song.albumArt,
                                      width: 56,
                                      height: 56,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    song.title,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  subtitle: Text(
                                    song.artist,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.favorite_rounded, color: AppTheme.primaryColor),
                                    onPressed: () => musicProvider.toggleFavorite(song),
                                  ),
                                  onTap: () {
                                    musicProvider.playSong(song);
                                    Navigator.pushNamed(context, '/player');
                                  },
                                ),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 400.ms, delay: (100 + (index * 50)).ms).slideX(begin: 0.1, end: 0);
                      },
                      childCount: musicProvider.favoriteSongs.length,
                    ),
                  ),
                ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ),
            ],
          );
        },
      ),
    );
  }
}
