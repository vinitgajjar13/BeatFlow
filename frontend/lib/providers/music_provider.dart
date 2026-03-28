import 'package:flutter/foundation.dart';
import '../models/song_model.dart';
import '../models/playlist_model.dart';
import '../models/artist_model.dart';
import '../models/album_model.dart';

class MusicProvider extends ChangeNotifier {
  // Mock data - replace with API calls
  List<Song> _allSongs = [];
  List<Song> _favoriteSongs = [];
  List<Playlist> _playlists = [];
  List<Artist> _artists = [];
  List<Album> _albums = [];
  Song? _currentSong;
  List<Song> _queue = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  
  MusicProvider() {
    initializeData();
  }

  // Getters
  List<Song> get allSongs => _allSongs;
  List<Song> get favoriteSongs => _favoriteSongs;
  List<Playlist> get playlists => _playlists;
  List<Artist> get artists => _artists;
  List<Album> get albums => _albums;
  Song? get currentSong => _currentSong;
  List<Song> get queue => _queue;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;

  // Initialize with sample data
  void initializeData() {
    _initializeSampleSongs();
    _initializeSamplePlaylists();
    _initializeSampleArtists();
    _initializeSampleAlbums();
  }

  void _initializeSampleSongs() {
    _allSongs = [
      Song(
        title: 'Do I Wanna Know?',
        artist: 'Arctic Monkeys',
        albumArt: 'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?q=80&w=500&auto=format&fit=crop',
        duration: const Duration(minutes: 4, seconds: 32),
        albumName: 'AM',
        releaseDate: DateTime(2013, 9, 9),
      ),
      Song(
        title: 'Neon Pulse',
        artist: 'The Midnight',
        albumArt: 'https://images.unsplash.com/photo-1619983081563-430f63602796?q=80&w=500&auto=format&fit=crop',
        duration: const Duration(minutes: 3, seconds: 55),
        albumName: 'Endless Summer',
        releaseDate: DateTime(2016, 8, 5),
      ),
      Song(
        title: 'Midnight City',
        artist: 'M83',
        albumArt: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=500&auto=format&fit=crop',
        duration: const Duration(minutes: 4, seconds: 3),
        albumName: 'Hurry Up, We\'re Dreaming',
        releaseDate: DateTime(2011, 10, 18),
      ),
      Song(
        title: 'Electric Feel',
        artist: 'MGMT',
        albumArt: 'https://images.unsplash.com/photo-1493225255756-d9584f8606e9?q=80&w=500&auto=format&fit=crop',
        duration: const Duration(minutes: 3, seconds: 48),
        albumName: 'Oracular Spectacular',
        releaseDate: DateTime(2007, 10, 2),
      ),
      Song(
        title: 'Starboy',
        artist: 'The Weeknd',
        albumArt: 'https://images.unsplash.com/photo-1459749411177-042180ce673c?q=80&w=500&auto=format&fit=crop',
        duration: const Duration(minutes: 3, seconds: 50),
        albumName: 'Starboy',
        releaseDate: DateTime(2016, 11, 25),
      ),
    ];
  }

  void _initializeSamplePlaylists() {
    _playlists = [
      Playlist(
        name: 'Liked Songs',
        description: 'Your favorite tracks',
        coverImage: 'https://images.unsplash.com/photo-1496293455970-f8581aae0e3c?q=80&w=500&auto=format&fit=crop',
        createdDate: DateTime.now(),
        songs: _allSongs.toList(),
      ),
      Playlist(
        name: 'Midnight Cyberpunk',
        description: 'Retro futuristic vibes',
        coverImage: 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=500&auto=format&fit=crop',
        createdDate: DateTime.now(),
        songs: [_allSongs[1], _allSongs[2]],
      ),
    ];
  }

  void _initializeSampleArtists() {
    _artists = [
      Artist(
        name: 'Arctic Monkeys',
        profileImage: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d7?q=80&w=500&auto=format&fit=crop',
        genre: 'Indie Rock',
        followers: 25000000,
      ),
      Artist(
        name: 'The Weeknd',
        profileImage: 'https://images.unsplash.com/photo-1514525253361-bee8d423b715?q=80&w=500&auto=format&fit=crop',
        genre: 'R&B/Pop',
        followers: 85000000,
      ),
    ];
  }

  void _initializeSampleAlbums() {
    _albums = [
      Album(
        name: 'AM',
        artist: 'Arctic Monkeys',
        coverArt: 'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?q=80&w=500&auto=format&fit=crop',
        releaseDate: DateTime(2013, 9, 9),
        songs: [_allSongs[0]],
      ),
      Album(
        name: 'Starboy',
        artist: 'The Weeknd',
        coverArt: 'https://images.unsplash.com/photo-1459749411177-042180ce673c?q=80&w=500&auto=format&fit=crop',
        releaseDate: DateTime(2016, 11, 25),
        songs: [_allSongs[4]],
      ),
    ];
  }

  // Music control methods
  void playSong(Song song) {
    _currentSong = song;
    _isPlaying = true;
    _queue = [song];
    notifyListeners();
  }

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void nextSong() {
    if (_currentIndex < _queue.length - 1) {
      _currentIndex++;
      _currentSong = _queue[_currentIndex];
      notifyListeners();
    }
  }

  void previousSong() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _currentSong = _queue[_currentIndex];
      notifyListeners();
    }
  }

  void toggleFavorite(Song song) {
    if (_favoriteSongs.contains(song)) {
      _favoriteSongs.remove(song);
    } else {
      _favoriteSongs.add(song);
    }
    notifyListeners();
  }

  void addToQueue(List<Song> songs) {
    _queue.addAll(songs);
    notifyListeners();
  }

  void createPlaylist(Playlist playlist) {
    _playlists.add(playlist);
    notifyListeners();
  }
}
