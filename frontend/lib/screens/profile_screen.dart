import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
      ),
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1DB954),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF282828),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.favorite,
                              color: Color(0xFF1DB954)),
                          title: const Text(
                            'Liked Songs',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Text(
                            '${musicProvider.favoriteSongs.length}',
                            style: const TextStyle(
                              color: Color(0xFFB3B3B3),
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(context, '/favorites'),
                        ),
                        const Divider(
                          color: Color(0xFF404040),
                          height: 1,
                        ),
                        ListTile(
                          leading: const Icon(Icons.library_music,
                              color: Color(0xFF1DB954)),
                          title: const Text(
                            'My Playlists',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Text(
                            '${musicProvider.playlists.length}',
                            style: const TextStyle(
                              color: Color(0xFFB3B3B3),
                            ),
                          ),
                          onTap: () =>
                              Navigator.pushNamed(context, '/my-playlists'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
