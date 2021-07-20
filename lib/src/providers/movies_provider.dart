import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/env.dart';
import 'package:movies/src/models/models.dart';

class MoviesProvider with ChangeNotifier {
  String _apiKey = Env.APIKEY;
  String _baseUrl = Env.BASE_URL;
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularsPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData({required String path, int page = 1}) async {
    final url = Uri.https(
      _baseUrl,
      path,
      {'api_key': _apiKey, 'language': _language, 'page': '$page'},
    );
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final res = await _getJsonData(path: '3/movie/now_playing');
    final moviesRes = NowPlayingResponse.fromJson(res);
    onDisplayMovies = moviesRes.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularsPage++;
    final res =
        await _getJsonData(path: '3/movie/popular', page: _popularsPage);
    final moviesRes = PopularResponse.fromJson(res);
    popularMovies = [...popularMovies, ...moviesRes.results];
    notifyListeners();
  }
}
