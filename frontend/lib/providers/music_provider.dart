import 'package:flutter/foundation.dart';
import '../models/song_model.dart';
import '../models/playlist_model.dart';
import '../models/artist_model.dart';

class MusicProvider extends ChangeNotifier {
  // Mock data - replace with API calls
  List<Song> _allSongs = [];
  List<Song> _favoriteSongs = [];
  List<Playlist> _playlists = [];
  List<Artist> _artists = [];
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
  Song? get currentSong => _currentSong;
  List<Song> get queue => _queue;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;

  // Initialize with sample data
  void initializeData() {
    _initializeSampleSongs();
    _initializeSamplePlaylists();
    _initializeSampleArtists();
  }

  void _initializeSampleSongs() {
    _allSongs = [
      Song(
        title: 'Midnight City',
        artist: 'M83',
        albumArt: 'https://via.placeholder.com/300',
        duration: const Duration(minutes: 4, seconds: 10),
        albumName: 'Hurry Up, We\'re Dreaming',
        releaseDate: DateTime(2011, 10, 18),
      ),
      Song(
        title: 'Electric Feel',
        artist: 'MGMT',
        albumArt: 'https://via.placeholder.com/300',
        duration: const Duration(minutes: 3, seconds: 48),
        albumName: 'Oracular Spectacular',
        releaseDate: DateTime(2007, 4, 24),
      ),
      Song(
        title: 'Take Me Out',
        artist: 'Franz Ferdinand',
        albumArt: 'https://via.placeholder.com/300',
        duration: const Duration(minutes: 4, seconds: 4),
        albumName: 'Franz Ferdinand',
        releaseDate: DateTime(2004, 2, 9),
      ),
    ];
  }

  void _initializeSamplePlaylists() {
    _playlists = [
      Playlist(
        name: 'Chill Vibes',
        description: 'Relaxing songs to unwind',
        coverImage: 'https://via.placeholder.com/300',
        createdDate: DateTime.now(),
        songs: _allSongs.take(2).toList(),
      ),
      Playlist(
        name: 'Workout Mix',
        description: 'High energy tracks',
        coverImage: 'https://via.placeholder.com/300',
        createdDate: DateTime.now(),
      ),
    ];
  }

  void _initializeSampleArtists() {
    _artists = [
      Artist(
        name: 'The Weeknd',
        profileImage: 'https://via.placeholder.com/300',
        genre: 'Hip-Hop/R&B',
        followers: 85000000,
      ),
      Artist(
        name: 'Billie Eilish',
        profileImage: 'https://via.placeholder.com/300',
        genre: 'Alternative',
        followers: 110000000,
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
