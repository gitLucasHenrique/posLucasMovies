class Movie {
  int id;
  String title;
  String urlFoto;
  double vote_average;
  String overview;

Movie({
  this.id,
  this.title,
  this.urlFoto,
  this.vote_average,
  this.overview,
});

  factory Movie.fromJson(Map<String, dynamic> json)  {
    return Movie(
      id: json['id'] as int,
      title: json["title"] as String,
      urlFoto: "https://image.tmdb.org/t/p/w300"+json["poster_path"],
      vote_average: double.parse(json["vote_average"].toString()),
      overview: json["overview"] as String,
    );
  }

  Map toMap() {
    Map<String,dynamic> map = {
      "id": id,
      "title": title,
      "urlFoto": urlFoto,
      "vote_average": vote_average,
      "overview": overview,
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return title;
  }
}