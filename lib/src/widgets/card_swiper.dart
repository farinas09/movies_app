import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class CardSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detail', arguments: 'movie'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage("assets/loading.gif"),
                  image: NetworkImage('https://via.placeholder.com/300x400')),
            ),
          );
        },
      ),
    );
  }
}
