class LastFmArtistSearchEvent {
  final String artist;

  LastFmArtistSearchEvent({
    this.artist = "",
  });

  @override
  String toString() =>
      'LastFmArtistSearchEvent { searched artist: $artist}';
}
