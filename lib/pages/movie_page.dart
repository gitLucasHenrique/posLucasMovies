import 'package:flutter/material.dart';
import 'package:flutter_app/domain/movie.dart';
import 'package:flutter_app/widgets/star_display.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;

  const MoviePage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.greenAccent
        ),
        title: Text(
          movie.nome,
          style: TextStyle(
            color: Colors.greenAccent
          ),
        ),
        backgroundColor: Colors.black87,
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
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          leading: Container(),
          //title: Text(movie.nome),
          floating: false,
          pinned: false,
          flexibleSpace: new FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(20.0),
            title: Text("$movie",),
            centerTitle: true,
            background: Image.network(
              movie.urlFoto,
              fit: BoxFit.cover,
            ),
            collapseMode: CollapseMode.parallax,
          ),
          expandedHeight: 500,
          brightness: Brightness.dark,
        ),
        SliverFillRemaining(
          child: _body(),
        )
      ],
    );
  }

  _body() {
    return
    Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/film.jpeg"),fit: BoxFit.fill)
        ),
        padding: EdgeInsets.fromLTRB(65, 15, 65, 0),
        child: Column(
          children: <Widget>[
            Center(
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.amber,
                    size: 20,
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
