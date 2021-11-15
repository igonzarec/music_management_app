// Project imports:
import 'package:music_management_app/albums/local_albums/domain/last_fm_local_album.dart';

abstract class LastFmLocalAlbumsState {}

class LocalAlbumsInitial extends LastFmLocalAlbumsState {}

class LocalAlbumsLoadInProgress extends LastFmLocalAlbumsState {}

class LocalAlbumsLoadSuccess extends LastFmLocalAlbumsState {
  final List<LastFmLocalAlbum> albums;

  LocalAlbumsLoadSuccess({required this.albums});
}

class LocalAlbumsLoadFailed extends LastFmLocalAlbumsState {
  final Exception error;

  LocalAlbumsLoadFailed({required this.error});
}
