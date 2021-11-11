import 'dart:async';
import 'dart:developer';
import 'package:music_management_app/albums/core/domain/last_fm_db_album.dart';
import 'package:music_management_app/albums/core/domain/last_fm_db_track.dart';
import 'package:music_management_app/core/infrastructure/last_fm_database_helper.dart';

class LastFmTrackOperations {
  static const trackTable = 'track_table';
  static const trackId = 'track_id';
  static const trackName = 'track_name';

  // ignore: constant_identifier_names
  static const FK_track_album = 'FK_track_album';

  LastFmTrackOperations? lastFmTrackOperations;

  final dbProvider = LastFmDatabaseHelper.instance;

  Future<int> createTrack(LastFmDbTrack track) async {
    final db = await dbProvider.database;
    return await db.insert(trackTable, track.toMap());
  }

  Future<void> deleteFromAlbumFromId(int albumId) async {
    final db = await LastFmDatabaseHelper.instance.database;
    await db.delete(trackTable, where: '$FK_track_album = ?', whereArgs: [albumId]);
    return;
  }

  Future<List<LastFmDbTrack>> getAllTracks() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.query(trackTable);
    List<LastFmDbTrack> tracks =
        allRows.map((track) => LastFmDbTrack.fromMap(track)).toList();
    return tracks;
  }

  Future<List<LastFmDbTrack>> getAllTracksFromAlbum(LastFmDbAlbum album) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> allRows = await db.rawQuery('''
    SELECT * FROM $trackTable 
    WHERE $trackTable.$FK_track_album = ${album.id}
    ''');
    List<LastFmDbTrack> tracks =
        allRows.map((track) => LastFmDbTrack.fromMap(track)).toList();
    return tracks;
  }
}
