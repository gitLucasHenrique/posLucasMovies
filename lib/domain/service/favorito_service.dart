import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/movie.dart';

class FavoritosService {
  getMovies() => _movies.snapshots();

  CollectionReference get _movies => Firestore.instance.collection("movies");

  List<Movie> toList(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((document) => Movie.fromJson(document.data) )
        .toList();
  }

  Future<bool> favoritar(Movie movie) async {

    var document = _movies.document("${movie.id}");
    var documentSnapshot = await document.get();

    if (!documentSnapshot.exists) {
      print("${movie.title}, adicionado nos favoritos");
      document.setData(movie.toMap());

      return true;
    } else {
      print("${movie.title}, removido nos favoritos");
      document.delete();

      return false;
    }
  }

  Future<bool> exists(Movie movie) async {

    // Busca o movie no Firestore
    var document = _movies.document("${movie.id}");
    if(document == null) {
      return false;
    }

    var documentSnapshot = await document.get();

    // Verifica se o movie está favoritado
    return await documentSnapshot.exists;
  }
}