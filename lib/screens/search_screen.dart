import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../widgets/music_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  void _search(String query, MusicProvider musicProvider) {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    final results = [
      ...musicProvider.allSongs.where((song) =>
          song.title.toLowerCase().contains(query.toLowerCase()) ||
          song.artist.toLowerCase().contains(query.toLowerCase())),
      ...musicProvider.artists.where((artist) =>
          artist.name.toLowerCase().contains(query.toLowerCase())),
      ...musicProvider.playlists.where((playlist) =>
          playlist.name.toLowerCase().contains(query.toLowerCase())),
    ];

    setState(() => _searchResults = results);
  }

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
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search songs, artists...',
            hintStyle: const TextStyle(color: Color(0xFF999999)),
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFFB3B3B3),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) =>
              _search(value, Provider.of<MusicProvider>(context, listen: false)),
        ),
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Text(
                _searchController.text.isEmpty
                    ? 'Search for songs, artists, or playlists'
                    : 'No results found',
                style: const TextStyle(
                  color: Color(0xFFB3B3B3),
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return MusicCard(
                  title: result.title ?? result.name,
                  subtitle: result.artist ?? result.genre ?? result.description,
                  imageUrl: result.albumArt ?? result.profileImage ??
                      result.coverImage,
                  onTap: () {
                    if (result.title != null) {
                      // It's a song
                      Provider.of<MusicProvider>(context, listen: false)
                          .playSong(result);
                      Navigator.pushNamed(context, '/player');
                    }
                  },
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
