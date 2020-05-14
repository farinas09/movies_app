import 'package:flutter/material.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

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
              _createCasting(movie, context),
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
          textAlign: TextAlign.center,
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
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
                child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150.0,
                ),
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

  Widget _createCasting(Movie movie, BuildContext context) {
    final movieProvider = new MoviesProvider();
    return FutureBuilder(
      future: movieProvider.getCast(movie.id),
      builder: (context, AsyncSnapshot<List> snapshot) {

        if ( snapshot.hasData ) {
          return _createActorsPageWidget( snapshot.data );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActorsPageWidget(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1

        ),
        itemCount: actors.length,
        itemBuilder: (context, i) =>_actorCard(actors[i]),
      ),
    );
  }

  Widget _actorCard( Actor actor ) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/placeholder.png'),
              image: NetworkImage(actor.getPhoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ) 
    );
  }
}