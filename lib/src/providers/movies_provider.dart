import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  String _apiKey = '8e746ff58bd44f7d363277326269e6d6';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  //List<Movie> onDisplayMovies = [];
  //List<Movie> popularMovies   = [];

  MoviesProvider() {
    print("provider initialized");
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    final url = Uri.https(
      _baseUrl,
      '3/movie/now_playing',
      {'api_key': _apiKey, 'language': _language, 'page': '1'},
    );
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    print(decodedData);
  }
}
