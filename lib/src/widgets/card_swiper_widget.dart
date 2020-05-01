import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> list;

  CardSwiper({ @required this.list });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        autoplay: true,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height*0.5,
        itemBuilder: (BuildContext context,int index){
          return new ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(list[index].getPosterImg()),
          fit: BoxFit.cover),
          );
        },
        itemCount: list.length,
        //pagination: new SwiperPagination(),
      ),
    );
  }
}