import 'dart:async';
import 'package:music_management_app/albums/core/domain/last_fm_db_album.dart';
import 'package:music_management_app/core/infrastructure/last_fm_database_helper.dart';

class LastFmAlbumOperations {
  static const albumTable = 'liked_album_table';
  static const albumId = 'album_id';
  static const name = 'name';
  static const artist = 'artist';
  static const image = 'image';

  createAlbum(LastFmDbAlbum album) async {
    final db = await LastFmDatabaseHelper.instance.database;
    db.insert(albumTable, album.toMap());
  }

  Future<List<LastFmDbAlbum>> getAllAlbums() async {
    final db = await LastFmDatabaseHelper.instance.database;
    List<Map<String, dynamic>> allRows = await db.query(albumTable);
    List<LastFmDbAlbum> albums =
        allRows.map((album) => LastFmDbAlbum.fromMap(album)).toList();
    return albums;
  }
}
