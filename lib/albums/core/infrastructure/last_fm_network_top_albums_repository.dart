import 'package:dio/dio.dart';
import 'package:music_management_app/albums/core/domain/last_fm_album_details.dart';
import 'package:music_management_app/albums/core/domain/last_fm_top_album.dart';
import 'package:music_management_app/core/infrastructure/last_fm_client.dart';

class LastFmNetworkTopAlbumsRepository {
  final LastFmClient _lastFmClient = LastFmClient();

  Future<List<LastFmTopAlbum>> getTopAlbums(String artist) async {
    List<LastFmTopAlbum> topAlbums = [];

    //Expression to avoid albums with "null" word or generic titles, and thus,
    // objects with empty fields.
    final regexp =
        RegExp("(\\b(null)\\b)|(\\b(title)\\b)", caseSensitive: false);

    Map<String, dynamic> getTopAlbumsParams = {
      "method": "artist.gettopalbums", //default parameter
      "artist": artist,
    };

    final response =
        await _lastFmClient.get(queryParameters: getTopAlbumsParams);

    try {
      if (response.statusCode == 200) {
        final albumsData = (response.data["topalbums"]["album"] as List);

        //filter out albums with "null" word or generic titles
        for (var album in albumsData) {
          if (regexp.hasMatch(album['name'] as String) == false) {
            topAlbums.add(LastFmTopAlbum.fromMap(album));
          }
        }
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw e;
      }
    }
    return topAlbums;
  }

  Future<LastFmAlbumDetails?> getAlbumDetails(
      {required String artist, required String album}) async {
    Map<String, dynamic> getAlbumDetailsParams = {
      "method": "album.getinfo", //default parameter
      "artist": artist,
      "album": album,
    };
    final response =
        await _lastFmClient.get(queryParameters: getAlbumDetailsParams);

    try {
      if (response.statusCode == 200) {
        final albumsData = (response.data['album']);

        LastFmAlbumDetails albumDetails =
            LastFmAlbumDetails.fromMap(albumsData);

        return albumDetails;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw e;
      }
    }
  }
}
