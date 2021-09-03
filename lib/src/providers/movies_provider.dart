import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/env.dart';
import 'package:movies/src/helpers/debouncer.dart';
import 'package:movies/src/models/models.dart';

class MoviesProvider with ChangeNotifier {
  String _apiKey = Env.APIKEY;
  String _baseUrl = Env.BASE_URL;
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularsPage = 0;
  bool isLoading = false;

  Map<int, List<Cast>> moviesCast = {};

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  // ignore: close_sinks
  final StreamController<List<Movie>> _suggestionStreamContoller =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamContoller.stream;

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

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final res = await _getJsonData(path: '3/movie/$movieId/credits');
    final creditRes = CreditsResponse.fromJson(res);
    moviesCast[movieId] = creditRes.cast;
    return creditRes.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    print("search");
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    if (searchTerm != debouncer.value) {
      debouncer.value = '';
      debouncer.onValue = (value) async {
        final results = await this.searchMovies(value);
        isLoading = false;
        this._suggestionStreamContoller.add(results);
        notifyListeners();
      };

      final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
        debouncer.value = searchTerm;
        isLoading = true;
      });

      Future.delayed(Duration(milliseconds: 201)).then((_) {
        timer.cancel();
      });
    }
  }
}
