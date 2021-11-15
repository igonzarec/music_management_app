// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:music_management_app/albums/core/domain/last_fm_album.dart';
import 'package:music_management_app/albums/core/domain/last_fm_album_details.dart';
import 'package:music_management_app/albums/core/domain/last_fm_top_album.dart';
import 'package:music_management_app/albums/local_albums/domain/last_fm_local_album.dart';
import 'package:music_management_app/albums/local_albums/domain/last_fm_local_track.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_album_db_operations.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_track_db_operations.dart';

class LastFmAlbumStarCubit extends Cubit<LastFmAlbumStar> {
  LastFmAlbumStarCubit() : super(LastFmAlbumStar(isLiked: false));

  final LastFmDbAlbumOperations _lastFmDbAlbumOperations =
      LastFmDbAlbumOperations();
  final LastFmTrackOperations _fmTrackOperations = LastFmTrackOperations();

  Future<void> checkAlbumStatus(LastFmAlbum album) async {
    bool isLiked = false;

    if(album is LastFmTopAlbum){
      isLiked =
      await _lastFmDbAlbumOperations.isLiked(arAlbum: album.name, arArtist: album.artist);
    }

    if(album is LastFmLocalAlbum){
      isLiked =
      await _lastFmDbAlbumOperations.isLiked(arAlbum: album.name, arArtist: album.artist);
    }

    emit(LastFmAlbumStar(isLiked: isLiked));
  }

  Future<void> starAlbum({required LastFmAlbumDetails? albumDetails}) async {
    int albumId =
        await LastFmDbAlbumOperations().createAlbumFromNetwork(albumDetails);


    for(String name in albumDetails!.tracks){
      await _fmTrackOperations.createTrack(LastFmLocalTrack(albumId: albumId, name: name));
    }


    // albumDetails?.tracks.map((name) async {
    //   await LastFmTrackOperations()
    //       .createTrack(LastFmLocalTrack(albumId: albumId, name: name));
    // });

    bool isLiked = await _lastFmDbAlbumOperations.isLiked(
        arAlbum: albumDetails.name, arArtist: albumDetails.artist);

    emit(LastFmAlbumStar(isLiked: isLiked));
  }

  Future<void> unStarAlbum({required LastFmAlbumDetails? albumDetails}) async {
    await _lastFmDbAlbumOperations.deleteAlbumAndTracks(
        albumDetails!.artist, albumDetails.name);

    bool isLiked = await _lastFmDbAlbumOperations.isLiked(
        arAlbum: albumDetails.name, arArtist: albumDetails.artist);

    emit(LastFmAlbumStar(isLiked: isLiked));
  }
}

class LastFmAlbumStar {
  bool isLiked;

  LastFmAlbumStar({
    required this.isLiked,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastFmAlbumStar &&
          runtimeType == other.runtimeType &&
          isLiked == other.isLiked);

  @override
  int get hashCode => isLiked.hashCode;

  @override
  String toString() {
    return 'LastFmAlbumStar{' ' isLiked: $isLiked,' '}';
  }

  LastFmAlbumStar copyWith({
    bool? isLiked,
  }) {
    return LastFmAlbumStar(
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
