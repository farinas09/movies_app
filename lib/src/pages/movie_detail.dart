import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          _createAppBar(movie),
          SliverList(delegate: SliverChildListDelegate(
            [
              SizedBox(height: 10.0,),
              _posterTitle(movie, context),
              _description(movie, context),
              _description(movie, context),
              _description(movie, context),
              _description(movie, context),
              _description(movie, context),
              _description(movie, context),
              _description(movie, context),
            ]
          ))
        ]
      ),
      
    );
  }

  Widget _createAppBar(Movie movie) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.getBrackgroundImage()),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
          ),
      ),
    );

  }

  Widget _posterTitle(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
              child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
              ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  //textTheme.title is deprecated, use headline 6
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis
                  ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star),
                      Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1)
                    ],

                  )
              ]
            )
            )
        ],
      ),
    );
  }

  Widget _description(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify),
    );
  }
}