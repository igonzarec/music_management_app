// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/local_albums/application/last_fm_local_albums_event.dart';
import 'package:music_management_app/albums/local_albums/application/last_fm_local_albums_state.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_album_db_operations.dart';

class LastFmLocalAlbumsBloc
    extends Bloc<LocalAlbumsEvent, LastFmLocalAlbumsState> {
  final LastFmDbAlbumOperations _lastFmDbAlbumOperations =
      LastFmDbAlbumOperations();

  LastFmLocalAlbumsBloc() : super(LocalAlbumsInitial());


  @override
  Stream<LastFmLocalAlbumsState> mapEventToState(
      LocalAlbumsEvent event) async* {
    yield LocalAlbumsLoadInProgress();
    try {
      final localAlbums = await _lastFmDbAlbumOperations.getAllAlbums();
      yield LocalAlbumsLoadSuccess(albums: localAlbums);
    } on Exception catch (e) {
      yield LocalAlbumsLoadFailed(error: e);
    }
  }
}
