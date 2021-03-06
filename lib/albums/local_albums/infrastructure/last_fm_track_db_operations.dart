// Dart imports:
import 'dart:async';

// Project imports:
import 'package:music_management_app/albums/local_albums/domain/last_fm_local_album.dart';
import 'package:music_management_app/albums/local_albums/domain/last_fm_local_track.dart';
import 'package:music_management_app/core/infrastructure/last_fm_database_helper.dart';

class LastFmTrackOperations {
  static const trackTable = 'track_table';
  static const trackId = 'track_id';
  static const trackName = 'track_name';

  // ignore: constant_identifier_names
  static const FK_track_album = 'FK_track_album';

  LastFmTrackOperations? lastFmTrackOperations;

  final dbProvider = LastFmDatabaseHelper.instance;

  Future<int> createTrack(LastFmLocalTrack track) async {
    final db = await dbProvider.database;
    return await db.insert(trackTable, track.toMap());
  }

  Future<void> deleteFromAlbumFromId(int? albumId) async {
    final db = await LastFmDatabaseHelper.instance.database;
    await db
        .delete(trackTable, where: '$FK_track_album = ?', whereArgs: [albumId]);
    return;
  }

  Future<List<LastFmLocalTrack>> getAllTracks() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.query(trackTable);
    List<LastFmLocalTrack> tracks =
        allRows.map((track) => LastFmLocalTrack.fromMap(track)).toList();
    return tracks;
  }

  Future<List<LastFmLocalTrack>> getAllTracksFromAlbum(
      LastFmLocalAlbum album) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.rawQuery('''
    SELECT * FROM $trackTable 
    WHERE $trackTable.$FK_track_album = ${album.id}
    ''');
    List<LastFmLocalTrack> tracks =
        allRows.map((track) => LastFmLocalTrack.fromMap(track)).toList();

    return tracks;
  }
}
