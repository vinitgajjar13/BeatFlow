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
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isSmallScreen = screenHeight < 700;

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
                          Colors.black.withValues(alpha: 0.4),
                          Colors.black.withValues(alpha: 0.8),
                          Colors.black,
                        ],
                        stops: const [0.0, 0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                      vertical: screenHeight * 0.1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          page['title'],
                          style: TextStyle(
                            color: page['titleColor'],
                            fontSize: isSmallScreen ? 36 : 48,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          page['subtitle'],
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.12),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: isSmallScreen ? 30 : 60,
            left: screenWidth * 0.06,
            right: screenWidth * 0.06,
            child: _currentPage == 2
                ? Row(
                    children: [
                      Expanded(
                        child: _buildNextButton(isBlack: true, height: isSmallScreen ? 48 : 56),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _buildSkipButton(height: isSmallScreen ? 48 : 56),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildNextButton(isBlack: false, height: isSmallScreen ? 48 : 56),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkipButton({required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, '/home'),
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          child: const Center(
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton({required bool isBlack, required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: isBlack ? null : AppTheme.primaryGradient,
        color: isBlack ? Colors.black : null,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        boxShadow: [
          if (!isBlack)
            BoxShadow(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
        ],
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
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

