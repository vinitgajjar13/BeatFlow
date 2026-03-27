import 'package:uuid/uuid.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String albumArt;
  final Duration duration;
  final String albumName;
  final DateTime releaseDate;
  bool isFavorite;
  int playCount;

  Song({
    String? id,
    required this.title,
    required this.artist,
    required this.albumArt,
    required this.duration,
    required this.albumName,
    required this.releaseDate,
    this.isFavorite = false,
    this.playCount = 0,
  }) : id = id ?? const Uuid().v4();

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? albumArt,
    Duration? duration,
    String? albumName,
    DateTime? releaseDate,
    bool? isFavorite,
    int? playCount,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      albumArt: albumArt ?? this.albumArt,
      duration: duration ?? this.duration,
      albumName: albumName ?? this.albumName,
      releaseDate: releaseDate ?? this.releaseDate,
      isFavorite: isFavorite ?? this.isFavorite,
      playCount: playCount ?? this.playCount,
    );
  }
}
