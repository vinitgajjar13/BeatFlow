import 'package:uuid/uuid.dart';
import 'song_model.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String coverImage;
  final DateTime createdDate;
  final List<Song> songs;
  bool isPublic;

  Playlist({
    String? id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.createdDate,
    this.songs = const [],
    this.isPublic = false,
  }) : id = id ?? const Uuid().v4();

  int get songCount => songs.length;

  Duration get totalDuration {
    return songs.fold(Duration.zero, (sum, song) => sum + song.duration);
  }

  Playlist copyWith({
    String? id,
    String? name,
    String? description,
    String? coverImage,
    DateTime? createdDate,
    List<Song>? songs,
    bool? isPublic,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      createdDate: createdDate ?? this.createdDate,
      songs: songs ?? this.songs,
      isPublic: isPublic ?? this.isPublic,
    );
  }
}
