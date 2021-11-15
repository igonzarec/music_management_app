// Project imports:
import 'package:music_management_app/albums/core/domain/last_fm_album_details.dart';

class LastFmAlbumLocalDetailsState {
  final bool isLoading;
  final LastFmAlbumDetails? albumDetails;
  final bool hasError;

  LastFmAlbumLocalDetailsState({
    required this.isLoading,
    required this.albumDetails,
    required this.hasError,
  });

  factory LastFmAlbumLocalDetailsState.initial() {
    return LastFmAlbumLocalDetailsState(
      albumDetails: null,
      isLoading: false,
      hasError: false,
    );
  }

  factory LastFmAlbumLocalDetailsState.loading() {
    return LastFmAlbumLocalDetailsState(
      albumDetails: null,
      isLoading: true,
      hasError: false,
    );
  }

  factory LastFmAlbumLocalDetailsState.success(LastFmAlbumDetails? albumDetails) {
    return LastFmAlbumLocalDetailsState(
      albumDetails: albumDetails,
      isLoading: false,
      hasError: false,
    );
  }

  factory LastFmAlbumLocalDetailsState.error() {
    return LastFmAlbumLocalDetailsState(
      albumDetails: null,
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'LastFmAlbumDetailsState {albums: ${albumDetails.toString()}, isLoading: $isLoading, hasError: $hasError}';
}
