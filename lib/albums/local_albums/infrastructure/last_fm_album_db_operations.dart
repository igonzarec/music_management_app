import 'dart:async';
import 'dart:developer';
import 'package:music_management_app/albums/core/domain/last_fm_album_details.dart';
import 'package:music_management_app/albums/local_albums/domain/last_fm_local_album.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_track_db_operations.dart';
import 'package:music_management_app/core/infrastructure/last_fm_database_helper.dart';

class LastFmDbAlbumOperations {
  static const albumTable = 'liked_album_table';
  static const albumId = 'album_id';
  static const mbId = 'mb_id';
  static const name = 'name';
  static const artist = 'artist';
  static const image = 'image';

  Future<int> createAlbumFromLocal(LastFmLocalAlbum album) async {
    final db = await LastFmDatabaseHelper.instance.database;
    return await db.insert(albumTable, album.toMap());
  }

  Future<int> createAlbumFromNetwork(LastFmAlbumDetails? album) async {
    final db = await LastFmDatabaseHelper.instance.database;
    return await db.insert(albumTable, album!.toDatabaseMap());
  }

  //Review the time complexity of this function
  Future<LastFmLocalAlbum> getAlbumFromId(int? arId) async {
    final db = await LastFmDatabaseHelper.instance.database;
    final dbAlbumsMap =
        await db.query(albumTable, where: '$albumId =?', whereArgs: [arId]);
    return dbAlbumsMap.map((e) => LastFmLocalAlbum.fromMap(e)).first;
  }


  Future<bool> isLiked(
      {required String arAlbum, required String arArtist}) async {
    final db = await LastFmDatabaseHelper.instance.database;
    LastFmLocalAlbum lastFmLocalAlbum;

    try {
      final dbAlbumsMap = await db.rawQuery(
          'SELECT * FROM $albumTable WHERE $artist=? and $name=?',
          [arArtist, arAlbum]);
      lastFmLocalAlbum =
          dbAlbumsMap.map((e) => LastFmLocalAlbum.fromMap(e)).first;
    } catch (_) {
      return false;
    }

    return lastFmLocalAlbum.name.toLowerCase() == arAlbum.toLowerCase() &&
        lastFmLocalAlbum.artist.toLowerCase() == arArtist.toLowerCase();
  }

  Future<List<LastFmLocalAlbum>> getAllAlbums() async {
    List<LastFmLocalAlbum> albums = [];
    final db = await LastFmDatabaseHelper.instance.database;
    List<Map<String, dynamic>> allRows = await db.query(albumTable);
    albums = allRows.map((album) => LastFmLocalAlbum.fromMap(album)).toList();
    return albums;
  }

  Future<void> deleteAlbumAndTracks(String arArtist, String arAlbum) async {
    final db = await LastFmDatabaseHelper.instance.database;
    LastFmLocalAlbum lastFmLocalAlbum;

    try {
      final dbAlbumsMap = await db.rawQuery(
          'SELECT * FROM $albumTable WHERE $artist=? and $name=?',
          [arArtist, arAlbum]);
      lastFmLocalAlbum =
          dbAlbumsMap.map((e) => LastFmLocalAlbum.fromMap(e)).first;

      await db.delete(albumTable,
          where: '$albumId = ?', whereArgs: [lastFmLocalAlbum.id]);

      await LastFmTrackOperations().deleteFromAlbumFromId(lastFmLocalAlbum.id);
    } catch (_) {
      log("could not unlike album");
      throw _;
    }

    return;
  }
}
