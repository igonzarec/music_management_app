// Project imports:
import 'package:music_management_app/albums/core/domain/last_fm_album_details.dart';

class LastFmAlbumDetailsState {
  final bool isLoading;
  final LastFmAlbumDetails? albumDetails;
  final bool hasError;

  LastFmAlbumDetailsState({
    required this.isLoading,
    required this.albumDetails,
    required this.hasError,
  });

  factory LastFmAlbumDetailsState.initial() {
    return LastFmAlbumDetailsState(
      albumDetails: null,
      isLoading: false,
      hasError: false,
    );
  }

  factory LastFmAlbumDetailsState.loading() {
    return LastFmAlbumDetailsState(
      albumDetails: null,
      isLoading: true,
      hasError: false,
    );
  }

  factory LastFmAlbumDetailsState.success(LastFmAlbumDetails? albumDetails) {
    return LastFmAlbumDetailsState(
      albumDetails: albumDetails,
      isLoading: false,
      hasError: false,
    );
  }

  factory LastFmAlbumDetailsState.error() {
    return LastFmAlbumDetailsState(
      albumDetails: null,
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'LastFmAlbumDetailsState {albums: ${albumDetails.toString()}, isLoading: $isLoading, hasError: $hasError}';
}
