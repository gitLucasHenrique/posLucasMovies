import 'package:flutter/material.dart';
import 'package:flutter_app/domain/movie.dart';
import 'package:flutter_app/widgets/star_display.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;

  const MoviePage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.nome),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite,
                color: Colors.white,
            ),
            onPressed: () => _onClickFavoritar(context),
          )
        ],
      ),
      body: _sliver(context),
    );
  }

  _sliver(context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          leading: Container(),
          //title: Text(movie.nome),
          floating: false,
          pinned: false,
          flexibleSpace: new FlexibleSpaceBar(
            background: Image.network(movie.urlFoto,
            fit: BoxFit.cover,
            ),
            collapseMode: CollapseMode.parallax,
          ),
          expandedHeight: 350,
        ),
        SliverFillRemaining(
          child: _body(),
        )
      ],
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Center(
            child: IconTheme(
              data: IconThemeData(
              color: Colors.amber,
              size: 25,
              ),
              child: StarDisplay(
                value: movie.vote_average.toInt(),
              ),
            )
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Text(
              movie.overview,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }

  _onClickFavoritar(context) {
    print("favoritar clicked");
  }
}
