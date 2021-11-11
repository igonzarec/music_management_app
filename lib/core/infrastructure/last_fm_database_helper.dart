import 'dart:io';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_album_db_operations.dart';
import 'package:music_management_app/albums/local_albums/infrastructure/last_fm_track_db_operations.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class LastFmDatabaseHelper {
  static const _likedAlbumsDatabaseName = "last_fm_albums.db43";
  static const _likedAlbumsDatabaseVersion = 1;

  LastFmDatabaseHelper._();

  static final LastFmDatabaseHelper instance = LastFmDatabaseHelper._();
  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _likedAlbumsDatabaseName);
    return await openDatabase(path,
        version: _likedAlbumsDatabaseVersion, onCreate: _onCreate);
  }

  //Eventually more tables could be created
  Future _onCreate(Database db, int version) async {
    //create track table
    await db.execute('''
          CREATE TABLE ${LastFmTrackOperations.trackTable} (
            ${LastFmTrackOperations.trackId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${LastFmTrackOperations.trackName} STRING NOT NULL,
            ${LastFmTrackOperations.FK_track_album} INT NOT NULL,
            FOREIGN KEY (${LastFmTrackOperations.FK_track_album}) REFERENCES ${LastFmAlbumOperations.albumTable} (${LastFmAlbumOperations.albumId})
          )
          ''');
    //create album table and connect with foreign key to category id
    await db.execute('''
          CREATE TABLE ${LastFmAlbumOperations.albumTable} (
            ${LastFmAlbumOperations.albumId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${LastFmAlbumOperations.mbId} INT NOT NULL,
            ${LastFmAlbumOperations.name} STRING NOT NULL,
            ${LastFmAlbumOperations.artist} STRING NOT NULL,
            ${LastFmAlbumOperations.image} STRING NOT NULL
          )
          ''');
  }
}

//track
