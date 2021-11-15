import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:music_management_app/core/domain/models/last_fm_error.dart';
import 'package:music_management_app/core/infrastructure/last_fm_client.dart';

class LastFmNetworkTracksRepository {
  final LastFmClient _lastFmClient = LastFmClient();

  Future<List<String>> getTracks(String artist, String album) async {
    List<String> tracks = [];

    Map<String, dynamic> getAlbumsTracks = {
      "method": "album.getinfo",
      "artist": artist,
      "album": album,
    };

    try {
      final response =
          await _lastFmClient.get(queryParameters: getAlbumsTracks);

      if (response.statusCode == 200) {
        final tracksData = (response.data['album']['tracks']['track'] as List);

        tracks = tracksData.map((e) {
          return e["name"].toString();
        }).toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        var lastFmError = LastFmError.fromJson(e.response?.data);
        log("${lastFmError.error} : ${lastFmError.message}");
        throw e;
      }
    }
    return tracks;
  }
}
