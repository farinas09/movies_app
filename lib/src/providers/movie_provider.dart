import 'dart:convert';

import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {

  String _apikey = '2ca8b6e3fe519daf4a1c0a911b3e58ea';
  String _url    = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> getCinemaMovies () async {
    final url = Uri.https(_url, '/3/movie/now_playing/', {
      'api_key' : _apikey,
      'language' : _language
    });

    //response from api
    final response = await http.get(url);

    //decodingData
    final decodedData = json.decode(response.body);
    print(decodedData);

    final moviesList = new Movies.fromJsonList(decodedData['results']);

    return moviesList.movies;
  }
}