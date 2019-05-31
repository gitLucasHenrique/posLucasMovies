import 'dart:async';

import 'package:flutter_app/domain/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDB {
  static final MovieDB _instance = new MovieDB.getInstance();

  factory MovieDB() => _instance;

  MovieDB.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movies.db');
    print("db $path");

    // para testes vc pode deletar o banco
    await deleteDatabase(path); ///data/user/0/com.example.flutter_app/databases/movies.db

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE movie(id INTEGER PRIMARY KEY, title TEXT, poster_path TEXT, vote_average TEXT, overview TEXT)');
  }

  Future<int> saveMovie(Movie movie) async {
    var dbClient = await db;
    final sql =
        'insert or replace into movie (id,title,poster_path,vote_average,overview) VALUES (?,?,?,?,?)';
    print(sql);
    var id = await dbClient.rawInsert(sql, [
      movie.id,
      movie.title,
      movie.poster_path,
      movie.vote_average,
      movie.overview
    ]);
    print('id: $id');
    return id;
  }

  Future<List<Movie>> getMovies() async {
    final dbClient = await db;

    final mapMovies = await dbClient.rawQuery('select * from movie');

    final movies = mapMovies.map<Movie>((json) => Movie.fromJson(json)).toList();

    return movies;
  }

  Future<int> getCount() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from movie');
    return Sqflite.firstIntValue(result);
  }

  Future<Movie> getMovie(int id) async {
    var dbClient = await db;
    final result = await dbClient.rawQuery('select * from movie where id = ?',[id]);

    if (result.length > 0) {
      return new Movie.fromJson(result.first);
    }

    return null;
  }

  Future<bool> exists(Movie movie) async {
    Movie c = await getMovie(movie.id);
    var exists = c != null;
    return exists;
  }

  Future<int> deleteMovie(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from movie where id = ?',[id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}