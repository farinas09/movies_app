import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movie_provider.dart';

class DataSearch extends SearchDelegate{

  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // The actions of the appbar

    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = '';
      }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // appbar left icon
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //close is a default method of a delegate
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // builder to create the results
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // suggestions that appears when the user writes

    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: moviesProvider.getSearch(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          
          if (snapshot.hasData) {
            final movies = snapshot.data;
            
            return ListView(
              children: movies.map( (movie) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/placeholder.png'), 
                    image: NetworkImage(movie.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.voteAverage.toString()),
                  onTap: () {
                    close(context, null);
                    movie.uniqueId = '';
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        
        );
    }

  }

}