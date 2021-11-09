import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:music_management_app/core/domain/models/last_fm_error.dart';
import 'package:music_management_app/core/infrastructure/last_fm_client.dart';
import 'package:music_management_app/search_artists/domain/models/last_fm_artist.dart';

class LastFmArtistsRepository {
  final LastFmClient _lastFmClient = LastFmClient();

  Future<List<LastFmArtist>> getArtists(
      String artist, int page, int limit) async {
    Map<String, dynamic> searchArtistParams = {
      "method": "artist.search",
      "artist": artist,
      "page": page,
      "limit": limit,
    };

    List<LastFmArtist> artists = [];

    try {
      var response =
          await _lastFmClient.get(queryParameters: searchArtistParams);

      if (response.statusCode == 200) {
        final userdata =
            (response.data["results"]["artistmatches"]["artist"] as List);

        artists = userdata.map((e) => LastFmArtist.fromMap(e)).toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        var lastFmError = LastFmError.fromJson(e.response?.data);
        log("${lastFmError.error} : ${lastFmError.message}");
        // //TODO: handle this error in state functionality, then uncomment next line.
        // throw e;
      }
    }
    return artists;
  }
}
