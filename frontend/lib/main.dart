import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/music_provider.dart';
import 'providers/player_provider.dart';
import 'core/theme/app_theme.dart';
import 'screens/home/home_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/library/favorites_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/auth/onboarding_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/player/player_screen.dart';
import 'screens/library/recently_played_screen.dart';
import 'screens/artist/artist_detail_screen.dart';
import 'screens/album/album_detail_screen.dart';
import 'screens/discover/category_detail_screen.dart';
import 'screens/profile/settings_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/profile/notifications_screen.dart';
import 'widgets/aura_background.dart';
import 'widgets/mini_player.dart';
import 'models/artist_model.dart';
import 'models/album_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ],
      child: MaterialApp(
        title: 'BeatFlow',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const _RootNavigator(),
          '/player': (context) => const PlayerScreen(),
          '/search': (context) => const SearchScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/recently-played': (context) => const RecentlyPlayedScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/edit-profile': (context) => const EditProfileScreen(),
          '/notifications': (context) => const NotificationsScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/artist-detail') {
            final artist = settings.arguments as Artist;
            return MaterialPageRoute(
              builder: (context) => ArtistDetailScreen(artist: artist),
            );
          } else if (settings.name == '/album-detail') {
            final album = settings.arguments as Album;
            return MaterialPageRoute(
              builder: (context) => AlbumDetailScreen(album: album),
            );
          } else if (settings.name == '/category-detail') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CategoryDetailScreen(
                categoryName: args['name'],
                categoryColor: args['color'],
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}

class _RootNavigator extends StatefulWidget {
  const _RootNavigator({Key? key}) : super(key: key);

  @override
  State<_RootNavigator> createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<_RootNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _buildDynamicBackground(context),
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 88, // Above Gatsby Nav Bar
            child: const MiniPlayer(),
          ),
        ],
      ),
      bottomNavigationBar: _buildGlassyNavBar(context),
    );
  }

  Widget _buildDynamicBackground(BuildContext context) {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, child) {
        final bool isDark = Theme.of(context).brightness == Brightness.dark;

        return AuraBackground(
          isDarkMode: isDark,
          accentColor:
              musicProvider.currentSong != null ? AppTheme.primaryColor : null,
        );
      },
    );
  }

  Widget _buildGlassyNavBar(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalMargin = screenWidth < 360 ? 12 : 20;

    return SafeArea(
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 20),
        height: 76,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: Theme.of(context).cardColor.withValues(alpha: 0.3),
          border: Border.all(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(38),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home_rounded, 0, 'Home'),
                _buildNavItem(Icons.search_rounded, 1, 'Search'),
                _buildNavItem(Icons.favorite_rounded, 2, 'Library'),
                _buildNavItem(Icons.person_rounded, 3, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    final isSelected = _selectedIndex == index;
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutQuart,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 18 : 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? primaryColor.withValues(alpha: 0.2)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? primaryColor
                  : Colors.white.withValues(alpha: 0.45),
              size: 26,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

}
