import 'package:flutter/material.dart';
import 'package:flutter_app/domain/movie.dart';
import 'package:flutter_app/domain/service/movie_service.dart';
import 'package:flutter_app/pages/favoritos_page.dart';
import 'package:flutter_app/widgets/movies_gridView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
              height: 2.1,
            ),
          ),
          backgroundColor: Colors.black87,
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.movie,color: Colors.greenAccent,)),
            Tab(icon: Icon(Icons.favorite_border,color: Colors.greenAccent,)),
          ],
          indicatorColor: Colors.greenAccent,
          ),
          title: Text("Movies"),
          iconTheme: IconThemeData(
              color: Colors.greenAccent
          ),
          centerTitle: true,
        ),
        body: _body(context),
      ),);
  }

  _body(context) {
    return TabBarView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/film.jpeg"),fit: BoxFit.fill)
          ),
          child: _gridBuilder(context),
        ),
        Container(
          color: Colors.green[100],
          child: _listBuilderFromBD(context),
        ),
      ],
    );
  }

  _listBuilderFromBD(context) {
    return FavoritosPage();
  }

  _gridBuilder(context) {
    Future<List<Movie>> movies = MovieService.getMovies();
    return FutureBuilder<List<Movie>>(
      future: movies,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Movie> movies = snapshot.data;
        return _gridView(context,movies);
      },
    );
  }

  _gridView(context, List<Movie> movies) {
    return MoviesGridView(movies);
  }
}
