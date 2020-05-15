import 'package:flutter/material.dart';
import 'package:movies/src/providers/movie_provider.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas'),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
            //query: "Hola " is argument to preload text y querybox
          )
        ]
      ),
      body: Container(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget> [
            _swiperCards(),
            _footer(context)
          ],
        ),
      )

    );
  }

  Widget _swiperCards() {
    
    return FutureBuilder(
      future: moviesProvider.getCinemaMovies(),
      builder: (BuildContext context, AsyncSnapshot <List> snapshot) {
        
        if(snapshot.hasData) {
          return CardSwiper(list: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
              )
            );
        }
        
        
      },
    );
  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares',
            style: Theme.of(context).textTheme.subtitle1),
            ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot <List> snapshot) {
              if(snapshot.hasData) {
                return MovieHorizontal(
                  movieslist: snapshot.data,
                  nextPage: moviesProvider.getPopulars);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}