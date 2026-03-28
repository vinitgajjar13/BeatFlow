import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/music_provider.dart';
import '../theme/app_theme.dart';
import '../models/album_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Provider.of<MusicProvider>(context, listen: false).initializeData();
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Let ambient background show through
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            backgroundColor: Colors.transparent, // Fully transparent
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                        ),
                        Text(
                          'Karsh',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: 40,
                                height: 1.1,
                              ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none_rounded, size: 28),
                          onPressed: () => Navigator.pushNamed(context, '/notifications'),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundImage: CachedNetworkImageProvider(
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RECENT ACTIVITY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 16),
                  Consumer<MusicProvider>(
                    builder: (context, provider, _) {
                      final items = provider.allSongs.take(4).toList();
                      final double screenWidth = MediaQuery.sizeOf(context).width;
                      final int crossAxisCount = screenWidth > 600 ? 3 : 2;
                      
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: screenWidth > 600 ? 3.5 : 2.5,
                        ),
                        itemCount: _isLoading ? 4 : items.length,
                        itemBuilder: (context, index) {
                          if (_isLoading) {
                            return Shimmer.fromColors(
                              baseColor: Theme.of(context).cardColor,
                              highlightColor: Colors.white.withValues(alpha: 0.1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: AppTheme.geometry,
                                ),
                              ),
                            );
                          }
                          final song = items[index];
                          return ClipRRect(
                            borderRadius: AppTheme.geometry,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardTheme.color,
                                borderRadius: AppTheme.geometry,
                                border: Border.all(color: Theme.of(context).dividerColor),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: AppTheme.radius,
                                      bottomLeft: AppTheme.radius,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: song.albumArt,
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        song.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().fadeIn(duration: 400.ms, delay: (400 + (index * 100)).ms).slideX(begin: 0.1, end: 0);
                          },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'TRENDING NOW',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 20),
                  Consumer<MusicProvider>(
                    builder: (context, provider, _) {
                      final double screenWidth = MediaQuery.sizeOf(context).width;
                      final double cardWidth = screenWidth > 600 ? 220 : 180;
                      
                      return SizedBox(
                        height: cardWidth + 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          itemCount: provider.allSongs.length,
                          itemBuilder: (context, index) {
                            final song = provider.allSongs[index];
                            final Album album = provider.albums.firstWhere(
                              (a) => a.name == song.albumName,
                              orElse: () => provider.albums[0],
                            );
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context, 
                                  '/album-detail',
                                  arguments: album,
                                );
                              },
                              child: Container(
                                width: cardWidth,
                                margin: const EdgeInsets.only(right: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: 'album-${album.id}',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: AppTheme.geometry,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.2),
                                              blurRadius: 20,
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: AppTheme.geometry,
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: song.albumArt,
                                                width: cardWidth,
                                                height: cardWidth,
                                                fit: BoxFit.cover,
                                              ),
                                              // Glassy play button overlay
                                              Positioned(
                                                bottom: 12,
                                                right: 12,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white.withValues(alpha: 0.4),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                                                    ),
                                                    child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      song.title,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      song.artist,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().fadeIn(duration: 500.ms, delay: (600 + (index * 100)).ms).slideX(begin: 0.2, end: 0);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 120), // Offset for floating nav bar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
