import 'package:dio/dio.dart';
import 'package:music_management_app/core/infrastructure/last_fm_client.dart';
import 'package:music_management_app/search/domain/models/last_fm_artist.dart';

class LastFmArtistsRepository {
  final LastFmClient _lastFmClient = LastFmClient();

  Future<List<LastFmArtist>> getArtists(String artist) async {
    List<LastFmArtist> artists = [];

    Map<String, dynamic> searchArtistParams = {
      "method": "artist.search",
      "artist": artist,
    };

    try {
      final response =
          await _lastFmClient.get(queryParameters: searchArtistParams);

      if (response.statusCode == 200) {
        final userdata =
            (response.data["results"]["artistmatches"]["artist"] as List);

        artists = userdata.map((e) => LastFmArtist.fromMap(e)).toList();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw e;
      }
    }
    return artists;
  }
}
