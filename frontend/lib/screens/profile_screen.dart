import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/music_provider.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Allow dynamic background
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withValues(alpha: 0.3),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
                          ),
                        ),
                      ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack, begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Karsh', // Updated to match Home
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 8),
                    Text(
                      'Premium Member',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn(context, 'FOLLOWERS', '1.2M').animate().fadeIn(delay: 400.ms),
                        Container(width: 1, height: 40, color: Colors.white.withValues(alpha: 0.2)).animate().fadeIn(delay: 400.ms),
                        _buildStatColumn(context, 'FOLLOWING', '450').animate().fadeIn(delay: 500.ms),
                      ],
                    ),
                    const SizedBox(height: 48),
                    ClipRRect(
                      borderRadius: AppTheme.geometry,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: AppTheme.geometry,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          child: Column(
                            children: [
                              _buildProfileTile(context, Icons.person_rounded, 'Manage Account',
                                onTap: () => Navigator.pushNamed(context, '/edit-profile')),
                              Divider(height: 1, color: Colors.white.withValues(alpha: 0.1)),
                              _buildProfileTile(context, Icons.notifications_rounded, 'Notifications',
                                onTap: () => Navigator.pushNamed(context, '/notifications')),
                              Divider(height: 1, color: Colors.white.withValues(alpha: 0.1)),
                              _buildProfileTile(context, Icons.settings_rounded, 'Settings',
                                onTap: () => Navigator.pushNamed(context, '/settings')),
                              Divider(height: 1, color: Colors.white.withValues(alpha: 0.1)),
                              _buildProfileTile(context, Icons.history_rounded, 'Recent Activity', 
                                onTap: () => Navigator.pushNamed(context, '/recently-played')),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 600.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: AppTheme.geometry,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withValues(alpha: 0.1),
                            borderRadius: AppTheme.geometry,
                            border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                            title: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: 700.ms).slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 120), // Offset for floating nav bar
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTile(BuildContext context, IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Theme.of(context).iconTheme.color, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      trailing: Icon(Icons.chevron_right_rounded, color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.5)),
      onTap: onTap,
    );
  }
}
