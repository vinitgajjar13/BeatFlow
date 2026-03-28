import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Pop', 'image': 'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?q=80&w=400&auto=format&fit=crop'},
    {'name': 'Rock', 'image': 'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?q=80&w=400&auto=format&fit=crop'},
    {'name': 'Hip-Hop', 'image': 'https://images.unsplash.com/photo-1557672172-298e090bd0f1?q=80&w=400&auto=format&fit=crop'},
    {'name': 'Indie', 'image': 'https://images.unsplash.com/photo-1514525253361-bee8d423b715?q=80&w=400&auto=format&fit=crop'},
    {'name': 'Electronic', 'image': 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=400&auto=format&fit=crop'},
    {'name': 'R&B', 'image': 'https://images.unsplash.com/photo-1459749411177-042180ce673c?q=80&w=400&auto=format&fit=crop'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Let dynamic background show through
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 48),
              ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1, end: 0),
              const SizedBox(height: 24),
              // Glassy Search Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: TextField(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'What do you want to listen to?',
                        prefixIcon: const Icon(Icons.search_rounded),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 20),
                        hintStyle: TextStyle(
                          color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 32),
              Text(
                'BROWSE ALL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 16),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final double screenWidth = MediaQuery.sizeOf(context).width;
                    final int crossAxisCount = screenWidth > 600 ? 3 : 2;
                    
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 120), // Leave space for nav
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: screenWidth > 600 ? 1.4 : 1.2,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context, 
                              '/category-detail',
                              arguments: {
                                'name': cat['name'],
                                'color': Colors.grey, // Legacy compat
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: AppTheme.geometry,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: cat['image'],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => const SizedBox(),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.2),
                                        Colors.black.withValues(alpha: 0.7),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    cat['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(duration: 400.ms, delay: (300 + (index * 100)).ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
