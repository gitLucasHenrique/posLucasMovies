
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/movie.dart';
import 'package:flutter_app/pages/movie_page.dart';
import 'package:flutter_app/utils/nav.dart';

class MoviesGridView extends StatelessWidget {
  final List<Movie> movies;
  const MoviesGridView(this.movies);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(55, 0, 55, 0),
      itemCount: movies.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, idx) {
        final m = movies[idx];

        return InkWell(
          onTap: () => _onClickMovie(context, m),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1)
            ),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Image.network(
              m.urlFoto ?? "http://www.livroandroid.com.br/livro/movies/esportivos/Ferrari_FF.png",
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }
  _onClickMovie(context, Movie m) {
    print("Movie $m");
    push(context, MoviePage(m));
  }
}
