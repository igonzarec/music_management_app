import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_track_db_operations.dart';

class LastFmDbTrack {
  int? id;
  String name;
  int albumId; //FK

  LastFmDbTrack({
    this.id,
    required this.name,
    required this.albumId,
  });

  factory LastFmDbTrack.fromMap(dynamic obj) {
    return LastFmDbTrack(
      id: obj[LastFmTrackOperations.trackId],
      name: obj[LastFmTrackOperations.trackName],
      albumId: obj[LastFmTrackOperations.FK_track_album],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      LastFmTrackOperations.trackName: name,
      LastFmTrackOperations.FK_track_album: albumId
    };

    return map;
  }

  //TODO: create function to instantiate from LastFmTrack

  @override
  String toString() {
    return 'LastFmDbTrack{'
        ' id: $id,'
        ' name: $name,'
        ' albumId: $albumId,'
        '}';
  }
}
