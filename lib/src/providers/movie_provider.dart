import 'dart:async';
import 'dart:convert';

import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {

  String _apikey = '2ca8b6e3fe519daf4a1c0a911b3e58ea';
  String _url    = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;
  bool _loading = false;
  
  List<Movie> _populars = new List();

  //Stream controller, broadcast for multiple listener
  final _popularsStreamController = new StreamController<List<Movie>>.broadcast();

  //add movies to stream
  Function(List<Movie>)get popularsSink => _popularsStreamController.sink.add;

  //to listen stream data
  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;


  void disposeStreams() {
    _popularsStreamController?.close();
  }
  

  Future<List<Movie>> getCinemaMovies () async {
    final url = Uri.https(_url, '/3/movie/now_playing/', {
      'api_key' : _apikey,
      'language' : _language
    });

    return await _decodeResponse(url);
  }

  Future<List<Movie>> getPopulars () async {

    if(_loading) return[];

    //validate if data is loading
    _loading = true;

    _popularsPage++;

    final url = Uri.https(_url, '/3/movie/popular/', {
      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularsPage.toString()
    });

    final response = await _decodeResponse(url);

    _populars.addAll(response);
    popularsSink(_populars);

    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(int movieId) async {
    final url = Uri.https(_url, '/3/movie/$movieId/credits', {
      //parametros
      'api_key' : _apikey,
      'language' : _language,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    //use 'cast'to do reference to cast model
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }


  Future<List<Movie>> _decodeResponse(Uri url) async {

    
    //response from api
    final response = await http.get(url);

    //decodingData
    final decodedData = json.decode(response.body);
    print(decodedData);

    final moviesList = new Movies.fromJsonList(decodedData['results']);

    return moviesList.movies;
  }
}