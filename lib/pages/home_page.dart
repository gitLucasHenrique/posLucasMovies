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
      padding: EdgeInsets.fromLTRB(55, 0, 55, 0),
      itemCount: movies.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, idx) {
        final c = movies[idx];

        return InkWell(
          onTap: () => _onClickMovie(context, c),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
                border: Border.all(color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1)
            ),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
