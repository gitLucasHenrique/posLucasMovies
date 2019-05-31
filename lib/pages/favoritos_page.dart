import 'package:flutter/material.dart';
import 'package:flutter_app/domain/db/movie_db.dart';
import 'package:flutter_app/domain/movie.dart';
import 'package:flutter_app/widgets/movies_listView.dart';
import 'package:flutter_app/widgets/star_display.dart';

class FavoritosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  _body(context) {
    Future<List<Movie>> future = MovieDB.getInstance().getMovies();

    return Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot){
          if(snapshot.hasData){
            final List<Movie> movies = snapshot.data;
            return MoviesListView(movies);
          }else if (snapshot.hasError){
            print(snapshot.error);
            return Center(
              child: Text("Erro ao carregar favoritos",style: TextStyle(
                fontSize: 26,
              ),),
            );
          }else{
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }
}
