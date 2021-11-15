// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/core/infrastructure/last_fm_network_top_albums_repository.dart';
import 'last_fm_top_albums_state.dart';

class LastFmTopAlbumsCubit extends Cubit<LastFmTopAlbumsState> {
  final String artistName;

  LastFmTopAlbumsCubit({
    required this.artistName,
  }) : super(LastFmTopAlbumsState.initial()) {
    showTopAlbums();
  }

  final LastFmNetworkTopAlbumsRepository _lastFmNetworkTopAlbumsRepository =
      LastFmNetworkTopAlbumsRepository();

  Future<void> showTopAlbums() async {
    emit(LastFmTopAlbumsState.loading());
    try {
      LastFmTopAlbumsState _state = LastFmTopAlbumsState.success(
          await _lastFmNetworkTopAlbumsRepository.getTopAlbums(artistName));
      emit(_state);
    } catch (_) {
      emit(LastFmTopAlbumsState.error());
    }
  }
}
