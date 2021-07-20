import 'package:flutter/material.dart';
import 'package:movies/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Películas"),
          elevation: 1,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CardSwiper(),
              MovieSlider(),
            ],
          ),
        ));
  }
}
