
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/movie.dart';
import 'package:flutter_app/pages/movie_page.dart';
import 'package:flutter_app/utils/nav.dart';

class MoviesListView extends StatelessWidget {
  final List<Movie> movies;
  const MoviesListView(this.movies);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, idx){
        final movie = movies[idx];
        return InkWell(
          child: ListTile(
            leading: Image.network(
              movie.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
              height: 50,
            ),
            title: Text(movie.title),
          ),
        );
      }
    );
  }
  _onClickMovie(context, Movie m) {
    print("Movie $m");
    push(context, MoviePage(m));
  }
}
