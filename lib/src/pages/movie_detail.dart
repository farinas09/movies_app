import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(child: Text(movie.title)),
      
    );
  }
}