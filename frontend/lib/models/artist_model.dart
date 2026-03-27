import 'package:uuid/uuid.dart';

class Artist {
  final String id;
  final String name;
  final String profileImage;
  final String genre;
  final int followers;
  final List<String> topSongs;
  bool isFollowing;

  Artist({
    String? id,
    required this.name,
    required this.profileImage,
    required this.genre,
    required this.followers,
    this.topSongs = const [],
    this.isFollowing = false,
  }) : id = id ?? const Uuid().v4();

  Artist copyWith({
    String? id,
    String? name,
    String? profileImage,
    String? genre,
    int? followers,
    List<String>? topSongs,
    bool? isFollowing,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      genre: genre ?? this.genre,
      followers: followers ?? this.followers,
      topSongs: topSongs ?? this.topSongs,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}
