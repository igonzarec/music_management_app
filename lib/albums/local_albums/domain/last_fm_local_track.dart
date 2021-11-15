import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_track_db_operations.dart';

class LastFmLocalTrack {
  int? id;
  String name;
  int? albumId; //FK

  LastFmLocalTrack({
    this.id,
    required this.name,
    required this.albumId,
  });

  factory LastFmLocalTrack.fromMap(dynamic obj) {
    return LastFmLocalTrack(
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

  @override
  String toString() {
    return name;
  }
}
