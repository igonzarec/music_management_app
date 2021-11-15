// Project imports:
import 'package:music_management_app/albums/core/domain/last_fm_album.dart';

class LastFmTopAlbum extends LastFmAlbum{
  final String name;
  final String artist;
  final String image; //take third object of list to get an acceptable size

   LastFmTopAlbum({
    required this.name,
    required this.artist,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastFmTopAlbum &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          artist == other.artist &&
          image == other.image);

  @override
  int get hashCode => name.hashCode ^ artist.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'LastFmTopAlbumDetails{'
        ' name: $name,'
        ' artist: $artist,'
        ' image: $image,'
        '}';
  }

  LastFmTopAlbum copyWith({
    String? name,
    String? artist,
    String? image,
  }) {
    return LastFmTopAlbum(
      name: name ?? this.name,
      artist: artist ?? this.artist,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'artist': artist,
      'image': image,
    };
  }

  factory LastFmTopAlbum.fromMap(Map<String, dynamic> map) {
    return LastFmTopAlbum(
      name: map['name'] as String,
      artist: map['artist']['name'] as String,
      image: map['image'][2]['#text'] as String,
    );
  }
}
