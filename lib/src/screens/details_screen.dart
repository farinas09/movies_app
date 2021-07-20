import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: Cambiar argumento
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "";
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTitle(),
            _OverView(),
            _OverView(),
            _OverView(),
            _OverView(),
          ]),
        ),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          color: Colors.black38,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "movie.title",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        background: FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage('https://via.placeholder.com/300x400'),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              height: 150,
              fit: BoxFit.cover,
              placeholder: AssetImage("assets/loading.gif"),
              image: NetworkImage('https://via.placeholder.com/300x400'),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Movie title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headline5,
              ),
              Text(
                "Original title",
                overflow: TextOverflow.ellipsis,
                style: textTheme.subtitle1,
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 20),
                  SizedBox(width: 5),
                  Text("Movie AVG", style: textTheme.caption),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Officia dolor proident deserunt sint consectetur fugiat officia nisi. Culpa esse ea nostrud veniam nostrud cupidatat. Eu consectetur quis culpa mollit. Minim labore eu mollit in nulla fugiat commodo irure est. Reprehenderit culpa ex mollit exercitation dolore consectetur mollit officia tempor commodo. Ullamco non esse minim minim tempor esse occaecat culpa. Irure ullamco minim officia laboris reprehenderit non.",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
