// Project imports:
import 'package:music_management_app/search/domain/models/last_fm_artist.dart';

class LastFmArtistSearchState {
  final bool isLoading;
  final List<LastFmArtist> artists;
  final bool hasError;

  LastFmArtistSearchState({
    required this.isLoading,
    required this.artists,
    required this.hasError,
  });

  factory LastFmArtistSearchState.initial() {
    return LastFmArtistSearchState(
      artists: [],
      isLoading: false,
      hasError: false,
    );
  }

  factory LastFmArtistSearchState.loading() {
    return LastFmArtistSearchState(
      artists: [],
      isLoading: true,
      hasError: false,
    );
  }

  factory LastFmArtistSearchState.success(List<LastFmArtist> artists) {
    return LastFmArtistSearchState(
      artists: artists,
      isLoading: false,
      hasError: false,
    );
  }

  factory LastFmArtistSearchState.error() {
    return LastFmArtistSearchState(
      artists: [],
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'LastFmArtistSearchState {artists: ${artists.toString()}, isLoading: $isLoading, hasError: $hasError}';
}
