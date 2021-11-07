// Root URL
//   http://ws.audioscrobbler.com/2.0/

// Search endpoint
//   /2.0/?method=artist.search&artist=cher&api_key=YOUR_API_KEY&format=json

import 'package:dio/dio.dart';



class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://reqres.in/api';

  // TODO: Add methods
}

//MAYBE DIO CLIENTS WILL BE IN EVERY FEATURE DEPENDING ON THE BASE URL AND ENDPOINTS
