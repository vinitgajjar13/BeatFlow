import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Music, made\nfor you.',
      'subtitle': 'Discover songs, artists, and playlists tailored to your vibe',
      'image': 'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?q=80&w=800&auto=format&fit=crop',
      'titleColor': AppTheme.onboardingOrange,
      'isWhiteNext': true,
    },
    {
      'title': 'Creating your\nmusic world.',
      'subtitle': 'Handpicking songs just for you 🎶',
      'image': 'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?q=80&w=800&auto=format&fit=crop',
      'titleColor': Colors.white,
      'isWhiteNext': true,
    },
    {
      'title': 'Choose your\nfavorite artists',
      'subtitle': 'We\'ll use this to build your perfect mix',
      'image': 'https://images.unsplash.com/photo-1459749411177-042180ce673c?q=80&w=800&auto=format&fit=crop',
      'titleColor': AppTheme.onboardingOrange,
      'isWhiteNext': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    page['image'],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.8),
                          Colors.black,
                        ],
                        stops: const [0.0, 0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 120.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          page['title'],
                          style: TextStyle(
                            color: page['titleColor'],
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['subtitle'],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 60,
            left: 24,
            right: 24,
            child: _currentPage == 2
                ? Row(
                    children: [
                      Expanded(
                        child: _buildNextButton(isBlack: true),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _buildSkipButton(),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildNextButton(isBlack: false),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, '/home'),
          borderRadius: BorderRadius.circular(28),
          child: const Center(
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton({required bool isBlack}) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isBlack ? AppTheme.pureBlack : AppTheme.pureWhite,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (_currentPage < _pages.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          borderRadius: BorderRadius.circular(28),
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(
                color: isBlack ? Colors.white : AppTheme.onboardingOrange,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
