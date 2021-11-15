// Project imports:
import 'package:music_management_app/albums/core/domain/last_fm_top_album.dart';

class LastFmTopAlbumsState {
  final bool isLoading;
  final List<LastFmTopAlbum> albums;
  final bool hasError;

  LastFmTopAlbumsState({
    required this.isLoading,
    required this.albums,
    required this.hasError,
  });

  factory LastFmTopAlbumsState.initial() {
    return LastFmTopAlbumsState(
      albums: [],
      isLoading: false,
      hasError: false,
    );
  }

  factory LastFmTopAlbumsState.loading() {
    return LastFmTopAlbumsState(
      albums: [],
      isLoading: true,
      hasError: false,
    );
  }

  factory LastFmTopAlbumsState.success(List<LastFmTopAlbum> albums) {
    return LastFmTopAlbumsState(
      albums: albums,
      isLoading: false,
      hasError: false,
    );
  }

  factory LastFmTopAlbumsState.error() {
    return LastFmTopAlbumsState(
      albums: [],
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'LastFmTopAlbumsState {albums: ${albums.toString()}, isLoading: $isLoading, hasError: $hasError}';
}
