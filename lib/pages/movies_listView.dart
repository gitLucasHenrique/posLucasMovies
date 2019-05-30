import 'package:flutter_app/domain/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MoviesListView extends StatefulWidget {
  final List<Movie> movies;

  final bool search;

  final ScrollController scrollController;

  final bool showProgress;

  final bool scrollToTheEnd;

  const MoviesListView(this.movies,
      {this.search = false, this.scrollController,this.showProgress=false, this.scrollToTheEnd = false});

  @override
  _MoviesListViewState createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {

  ScrollController get scrollController => widget.scrollController;
  bool get showProgress => widget.showProgress;
  List<Movie> get movies => widget.movies;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if(widget.scrollToTheEnd) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    return ListView.builder(
      controller: scrollController,
      itemCount: showProgress ? movies.length + 1 : movies.length,
      itemBuilder: (ctx, idx) {

        if (showProgress && movies.length == idx) {
          return Container(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Movie
        final m = widget.movies[idx];
        return Container(
          height: 280,
          child: InkWell(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        m.urlFoto ??
                            "http://www.livroandroid.com.br/livro/movies/esportivos/Ferrari_FF.png",
                        height: 150,
                      ),
                    ),
                    Text(
                      m.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      m.releaseDate,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }}