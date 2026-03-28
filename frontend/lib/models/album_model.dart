import 'package:uuid/uuid.dart';
import 'song_model.dart';

class Album {
  final String id;
  final String name;
  final String artist;
  final String coverArt;
  final String? description;
  final DateTime releaseDate;
  final List<Song> songs;

  Album({
    String? id,
    required this.name,
    required this.artist,
    required this.coverArt,
    this.description,
    required this.releaseDate,
    required this.songs,
  }) : id = id ?? const Uuid().v4();

  int get durationInSeconds {
    return songs.fold(0, (sum, song) => sum + song.duration.inSeconds);
  }

  String get formattedDuration {
    final duration = Duration(seconds: durationInSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '$hours hr $minutes min';
    }
    return '$minutes min';
  }
}
