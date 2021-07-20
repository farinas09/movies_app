import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/src/models/models.dart';

class MoviesProvider with ChangeNotifier {
  String _apiKey = '8e746ff58bd44f7d363277326269e6d6';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    final url = Uri.https(
      _baseUrl,
      '3/movie/now_playing',
      {'api_key': _apiKey, 'language': _language, 'page': '1'},
    );
    final response = await http.get(url);
    final moviesRes = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = moviesRes.results;
    notifyListeners();
  }

  getPopularMovies() async {
    final url = Uri.https(
      _baseUrl,
      '3/movie/popular',
      {'api_key': _apiKey, 'language': _language, 'page': '1'},
    );
    final response = await http.get(url);
    final moviesRes = PopularResponse.fromJson(response.body);
    popularMovies = [...popularMovies, ...moviesRes.results];
    notifyListeners();
  }
}
