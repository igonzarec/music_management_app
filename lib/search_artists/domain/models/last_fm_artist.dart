class LastFmArtist {
  
  LastFmArtist({
    required this.name,
  });
  
  final String name;

  //Data class methods
  
  factory LastFmArtist.fromMap(Map<String, dynamic> json) => LastFmArtist(
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
  };
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastFmArtist &&
          runtimeType == other.runtimeType &&
          name == other.name);

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'LastFmArtist{' ' name: $name,' '}';
  }

  LastFmArtist copyWith({
    String? name,
  }) {
    return LastFmArtist(
      name: name ?? this.name,
    );
  }
}
