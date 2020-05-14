import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Movie> movieslist;
  final Function nextPage;
  final _pageController = new PageController(
    initialPage:1,
    viewportFraction: 0.3
  );

  MovieHorizontal({ @required this.movieslist, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener((){

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height*0.25,
      //para crear bajo demanda
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movieslist.length,
        itemBuilder: (context, i) => _createCard(context, movieslist[i])
      )
      
    );
  }

  Widget _createCard (BuildContext context, Movie movie) {

    movie.uniqueId = '${ movie.id}-footer';

    final movieCard = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Text(movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,),
          ],
        ),
      );

      return GestureDetector(
        onTap: () {
          //use arguments to pass data to the pushed activity
          Navigator.pushNamed(context, 'detail', arguments: movie);
        },
        child: movieCard,
      );
  }

}