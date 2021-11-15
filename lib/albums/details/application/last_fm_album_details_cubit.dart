// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/core/domain/last_fm_album.dart';
import 'package:music_management_app/albums/core/domain/last_fm_album_details.dart';
import 'package:music_management_app/albums/core/domain/last_fm_top_album.dart';
import 'package:music_management_app/albums/core/infrastructure/last_fm_network_top_albums_repository.dart';
import 'package:music_management_app/albums/details/application/last_fm_album_details_state.dart';
import 'package:music_management_app/albums/local_albums/domain/last_fm_local_album.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_album_db_operations.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_track_db_operations.dart';

class LastFmAlbumDetailsCubit extends Cubit<LastFmAlbumDetailsState> {
  final LastFmAlbum album;

  LastFmAlbumDetailsCubit(this.album)
      : super(LastFmAlbumDetailsState.initial()) {
    if (album is LastFmLocalAlbum) {
      getAlbumDetailsFromDatabase(album as LastFmLocalAlbum);
    } else {
      getAlbumDetailsFromNetwork(album as LastFmTopAlbum);
    }
  }

  final LastFmNetworkTopAlbumsRepository _lastFmNetworkTopAlbumsRepository =
      LastFmNetworkTopAlbumsRepository();

  final LastFmTrackOperations _fmTrackOperations = LastFmTrackOperations();

  final LastFmDbAlbumOperations _lastFmDbAlbumOperations =
      LastFmDbAlbumOperations();

  Future<void> getAlbumDetailsFromNetwork(LastFmTopAlbum album) async {
    emit(LastFmAlbumDetailsState.loading());
    try {
      LastFmAlbumDetailsState _state = LastFmAlbumDetailsState.success(
          await _lastFmNetworkTopAlbumsRepository.getAlbumDetails(
              artist: album.artist, album: album.name));
      emit(_state);
    } catch (error) {
      emit(LastFmAlbumDetailsState.error());
      //Necessary for debugging
      throw error;
    }
  }

  Future<void> getAlbumDetailsFromDatabase(
      LastFmLocalAlbum arLocalAlbum) async {
    emit(LastFmAlbumDetailsState.loading());
    try {
      LastFmLocalAlbum album =
          await _lastFmDbAlbumOperations.getAlbumFromId(arLocalAlbum.id);
      List<String> tracks = await _fmTrackOperations
          .getAllTracksFromAlbum(album)
          .then((value) => value.map((e) => e.toString()).toList());

      LastFmAlbumDetailsState _state = LastFmAlbumDetailsState.success(
        LastFmAlbumDetails(
          tracks: tracks,
          artist: album.artist,
          mbid: album.mbid,
          name: album.name,
          image: "", //storing network images is currently not supported
        ),
      );
      emit(_state);
    } catch (error) {
      emit(LastFmAlbumDetailsState.error());
      //Necessary for debugging
      throw error;
    }
  }
}
