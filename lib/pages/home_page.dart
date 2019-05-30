import 'package:flutter/material.dart';
import 'package:flutter_app/domain/movie.dart';
import 'package:flutter_app/domain/service/favorito_service.dart';
import 'package:flutter_app/domain/service/movie_service.dart';
import 'package:flutter_app/utils/nav.dart';
import 'package:flutter_app/pages/movie_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        bottom: TabBar(tabs: [
          Tab(icon: Icon(Icons.movie)),
          Tab(icon: Icon(Icons.favorite_border)),
        ]),
        title: Text("Movies"),

      ),
      body: _body(context),
    ),);
  }

  _body(context) {
    return TabBarView(
      children: <Widget>[
        Container(
          color: Colors.green[100],
          child: _listBuilder(context),
        ),
        Container(
          color: Colors.green[100],
          child: _listBuilderFromBD(context),
        ),
      ],
    );
  }

  _listBuilderFromBD(context) {

    return Container(
      padding: EdgeInsets.all(12),
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("movies").snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Container(
              child: Center(
                child: Text("Carregando.."),
              ),
            );
          }else if(snapshot.hasError) {
            return Container(
              child: Center(
                child: Text("erro ao carregar dados"),
              ),
            );
          }
          final List<Movie> movies = snapshot.data.documents.map((DocumentSnapshot document){
            return Movie.fromJson(document.data);
          }).toList();
          return _listView(context, movies);
        }
      ),
    );
  }

  _listBuilder(context) {
    Future<List<Movie>> movies = MovieService.getMovies();
    final service = FavoritosService();

    return FutureBuilder<List<Movie>>(
      future: movies,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Movie> movies = snapshot.data;
        return _listView(context,movies);
      },
    );
  }

  _listView(context, List<Movie> movies) {
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, idx) {
        final c = movies[idx];

        return InkWell(
          onTap: () => _onClickMovie(context, c),

          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green,
              style: BorderStyle.solid,
              width: 3)
            ),
            padding: EdgeInsets.all(2),
            child: Image.network(
                c.urlFoto ?? "http://www.livroandroid.com.br/livro/movies/esportivos/Ferrari_FF.png",
                fit: BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }

  _onClickMovie(context, Movie c) {
    print("Movie $c");
    push(context, MoviePage(c));
  }

  _listViewFromDB(BuildContext context, List<Movie> movies) {

    return ListView.builder(
      itemBuilder: (context, idx){
        final m = movies[idx];
        return Container(
          child: Text(m.nome),
        );
      },
    );
  }
}
