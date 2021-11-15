// Dart imports:
import 'dart:async';
import 'dart:developer';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:music_management_app/search/application/last_fm_artist_search_event.dart';
import 'package:music_management_app/search/application/last_fm_artist_search_state.dart';
import 'package:music_management_app/search/domain/models/last_fm_artist.dart';
import 'package:music_management_app/search/infrastructure/last_fm_artists_repository.dart';

class LastFmArtistBloc
    extends Bloc<LastFmArtistSearchEvent, LastFmArtistSearchState> {
  LastFmArtistBloc(LastFmArtistSearchState initialState) : super(initialState) {
    on<LastFmArtistSearchEvent>(_onEvent,
        transformer: debounce(const Duration(milliseconds: 1000)));
  }

  FutureOr<void> _onEvent(LastFmArtistSearchEvent event, emitter) async {
    emitter(LastFmArtistSearchState.loading());

    if (event.artist.isNotEmpty) {
      try {
        List<LastFmArtist> artists =
            await _lastFmArtistsRepository.getArtists(event.artist);
        emitter(LastFmArtistSearchState.success(artists));
      } catch (_) {
        emitter(LastFmArtistSearchState.error());
      }
    } else {
      emitter(LastFmArtistSearchState.initial());
    }
  }

  EventTransformer<LastFmArtistSearchEvent> debounce<LastFmArtistSearchEvent>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  final LastFmArtistsRepository _lastFmArtistsRepository =
      LastFmArtistsRepository();

  LastFmArtistSearchState get initialState => LastFmArtistSearchState.initial();

  Future<void> getArtists({required String artist}) async {
    log("getting artists");
    return add(LastFmArtistSearchEvent(artist: artist));
  }

  @override
  void onTransition(
      Transition<LastFmArtistSearchEvent, LastFmArtistSearchState> transition) {
    super.onTransition(transition);
    log(transition.toString());
  }
}
