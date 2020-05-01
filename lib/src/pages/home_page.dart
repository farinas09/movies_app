import 'package:flutter/material.dart';
import 'package:movies/src/providers/movie_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas'),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){

            })
        ]
      ),
      body: Container(
        child: Column (
          children: <Widget> [
            _swiperCards()
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
}