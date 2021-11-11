import 'dart:async';
import 'package:music_management_app/albums/local_albums/domain/last_fm_db_album.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_track_db_operations.dart';
import 'package:music_management_app/core/infrastructure/last_fm_database_helper.dart';

class LastFmAlbumOperations {
  static const albumTable = 'liked_album_table';
  static const albumId = 'album_id';
  static const mbId = 'mb_id';
  static const name = 'name';
  static const artist = 'artist';
  static const image = 'image';

  Future<int> createAlbum(LastFmDbAlbum album) async {
    final db = await LastFmDatabaseHelper.instance.database;
    return await db.insert(albumTable, album.toMap());
  }

  //TODO: review the time complexity of this function
  Future<LastFmDbAlbum> getAlbumFromMbId(int arMbId) async {
    final db = await LastFmDatabaseHelper.instance.database;
    final dbAlbumsMap =
        await db.query(albumTable, where: '$mbId =?', whereArgs: [arMbId]);
    return dbAlbumsMap.map((e) => LastFmDbAlbum.fromMap(e)).first;
  }

  Future<List<LastFmDbAlbum>> getAllAlbums() async {
    final db = await LastFmDatabaseHelper.instance.database;
    List<Map<String, dynamic>> allRows = await db.query(albumTable);
    List<LastFmDbAlbum> albums =
        allRows.map((album) => LastFmDbAlbum.fromMap(album)).toList();
    return albums;
  }

  Future<void> deleteFromId(int arMbId) async {
    final db = await LastFmDatabaseHelper.instance.database;

    await LastFmTrackOperations().deleteFromAlbumFromId(arMbId);

    await db.delete(albumTable, where: '$mbId = ?', whereArgs: [arMbId]);

    return;
  }
}
