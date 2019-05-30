import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_app/domain/movie.dart';

class MovieService {
  static Future<List<Movie>> getMovies() async {

//    String s = await rootBundle.loadString("assets/json/movies.json");

    final url = "https://api.themoviedb.org/3/movie/popular?api_key=9ac4466dcf069ac63db44c560c9e8731&language=pt-BR";
    print("> get: $url");

    final response = await http.get(url);

    final mapMovies = json.decode(response.body);
    final mapResults = mapMovies["results"];

    List<Movie> movies = mapResults.map<Movie>((json) => Movie.fromJson(json)).toList();
    print(movies);
    try{
      return movies;
    }
    catch(error){
      print(error);
    }

  }
}
