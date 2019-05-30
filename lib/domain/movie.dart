class Movie {
  int id;
  String nome;
  String urlFoto;
  double vote_average;
  String releaseDate;
  String overview;

Movie(
{
  this.id,
  this.nome,
  this.urlFoto,
  this.vote_average,
  this.releaseDate,
  this.overview,
});

  factory Movie.fromJson(Map<String, dynamic> json)  {
    return Movie(
      id: json['id'] as int,
      nome: json["title"] as String,
      urlFoto: "https://image.tmdb.org/t/p/w300"+json["poster_path"] as String,
      vote_average: double.parse(json["vote_average"].toString()),
      releaseDate: json["release_date"] as String,
      overview: json["overview"] as String,
    );
  }

  Map toMap() {
    Map<String,dynamic> map = {
      "id": id,
      "nome": nome,
      "urlFoto": urlFoto,
      "vote_average": vote_average,
      "release_date": releaseDate,
      "overview": overview,
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return nome;
  }
}