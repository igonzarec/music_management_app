// Project imports:
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_album_db_operations.dart';

class LastFmAlbumDetails {
  final String artist;
  final String name;
  final String mbid;
  final String image;
  final List<String> tracks;

  LastFmAlbumDetails({
    required this.artist,
    required this.name,
    required this.mbid,
    required this.image,
    required this.tracks,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastFmAlbumDetails &&
          runtimeType == other.runtimeType &&
          artist == other.artist &&
          name == other.name &&
          mbid == other.mbid &&
          image == other.image &&
          tracks == other.tracks);

  @override
  int get hashCode =>
      artist.hashCode ^
      name.hashCode ^
      mbid.hashCode ^
      tracks.hashCode ^
      image.hashCode;

  @override
  String toString() {
    return 'LastFmAlbumDetails{'
        ' artist: $artist,'
        ' name: $name,'
        ' mbid: $mbid,'
        ' image: $image,'
        ' tracks: $tracks,'
        '}';
  }

  LastFmAlbumDetails copyWith({
    String? artist,
    String? name,
    String? mbid,
    String? image,
    List<String>? tracks,
    bool? isLocal,
  }) {
    return LastFmAlbumDetails(
      artist: artist ?? this.artist,
      name: name ?? this.name,
      mbid: mbid ?? this.mbid,
      image: image ?? this.image,
      tracks: tracks ?? this.tracks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'artist': artist,
      'name': name,
      'mbid': mbid,
      'image': image,
      'tracks': tracks,
    };
  }

  Map<String, dynamic> toDatabaseMap() {
    var map = <String, dynamic>{
      LastFmDbAlbumOperations.mbId: mbid,
      LastFmDbAlbumOperations.name: name,
      LastFmDbAlbumOperations.artist: artist,
      LastFmDbAlbumOperations.image: image,
    };

    return map;
  }

  ///Function to adapt to different return types of api in 'tracks' node
  static List<String> _validateTrackNodes(Map<String, dynamic> map) {
    if (map.containsKey("tracks")) {
      if (map["tracks"].containsKey("track")) {
        if (map["tracks"]["track"] is List) {
          return (map['tracks']['track'] as List)
              .map((e) => e["name"].toString())
              .toList();
        } else {
          return List<String>.from(
              [map['tracks']['track']['name'] as String]);
        }
      }
    }
    return [];
  }

  factory LastFmAlbumDetails.fromMap(Map<String, dynamic> map) {
    return LastFmAlbumDetails(
      artist: map['artist'] as String,
      name: map['name'] as String,
      mbid: map['mbid'] as String,
      tracks: _validateTrackNodes(map),
      image: map['image'][3]['#text'] as String,
    );
  }
}
