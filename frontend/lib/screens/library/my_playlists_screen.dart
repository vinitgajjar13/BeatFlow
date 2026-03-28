import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/music_provider.dart';
import '../../models/playlist_model.dart';
import '../../widgets/music_card.dart';

class MyPlaylistsScreen extends StatelessWidget {
  const MyPlaylistsScreen({Key? key}) : super(key: key);

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
        title: const Text('My Playlists'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                // Create new playlist
                showDialog(
                  context: context,
                  builder: (context) => const CreatePlaylistDialog(),
                );
              },
              child: const Icon(Icons.add_circle_outline),
            ),
          ),
        ],
      ),
      body: Consumer<MusicProvider>(
        builder: (context, musicProvider, _) {
          if (musicProvider.playlists.isEmpty) {
            return const Center(
              child: Text(
                'No playlists created yet',
                style: TextStyle(color: Color(0xFFB3B3B3)),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: musicProvider.playlists.length,
            itemBuilder: (context, index) {
              final playlist = musicProvider.playlists[index];
              return MusicCard(
                title: playlist.name,
                subtitle:
                    '${playlist.songCount} songs • ${playlist.totalDuration.inMinutes} min',
                imageUrl: playlist.coverImage,
                onTap: () => Navigator.pushNamed(
                  context,
                  '/playlist',
                  arguments: playlist,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CreatePlaylistDialog extends StatefulWidget {
  const CreatePlaylistDialog({Key? key}) : super(key: key);

  @override
  State<CreatePlaylistDialog> createState() => _CreatePlaylistDialogState();
}

class _CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF282828),
      title: const Text(
        'Create Playlist',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Playlist name',
              hintStyle: const TextStyle(color: Color(0xFFB3B3B3)),
              filled: true,
              fillColor: const Color(0xFF121212),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: 'Description',
              hintStyle: const TextStyle(color: Color(0xFFB3B3B3)),
              filled: true,
              fillColor: const Color(0xFF121212),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xFFB3B3B3)),
          ),
        ),
        TextButton(
          onPressed: () {
            final playlist = Playlist(
              name: _nameController.text,
              description: _descriptionController.text,
              coverImage: 'https://via.placeholder.com/300',
              createdDate: DateTime.now(),
            );
            Provider.of<MusicProvider>(context, listen: false)
                .createPlaylist(playlist);
            Navigator.pop(context);
          },
          child: const Text(
            'Create',
            style: TextStyle(color: Color(0xFF1DB954)),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

