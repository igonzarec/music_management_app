
class LastFmTopAlbumDetails {
  final String name;
  final String artist;
  final String image; //take third object of list to get an acceptable size
  final List<String> tracks;

  const LastFmTopAlbumDetails({
    required this.name,
    required this.artist,
    required this.image,
    this.tracks = const [],
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastFmTopAlbumDetails &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          artist == other.artist &&
          image == other.image);

  @override
  int get hashCode => name.hashCode ^ artist.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'LastFmTopAlbumDetails{' ' name: $name,' ' artist: $artist,' ' image: $image,' '}';
  }

  LastFmTopAlbumDetails copyWith({
    String? name,
    String? artist,
    String? image,
  }) {
    return LastFmTopAlbumDetails(
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

  factory LastFmTopAlbumDetails.fromMap(Map<String, dynamic> map) {
    return LastFmTopAlbumDetails(
      name: map['name'] as String,
      artist: map['artist']['name'] as String,
      image: map['image'][2]['#text'] as String,
    );
  }
}
