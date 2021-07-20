import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movies/src/models/models.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> movies;
  final String title;

  const MovieSlider({Key? key, required this.movies, this.title = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 265,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, int index) =>
                    _MoviePoster(movie: movies[index])),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detail', arguments: 'movie'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                height: 190,
                width: 130,
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/loading.gif"),
                image: NetworkImage(movie.fullPosterImg),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
