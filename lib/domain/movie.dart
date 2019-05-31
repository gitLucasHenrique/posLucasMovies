class Movie {
  int id;
  String title;
  String poster_path;
  double vote_average;
  String overview;

  String get urlFoto {
    return "https://image.tmdb.org/t/p/w300/"+poster_path;
  }
  
Movie({
  this.id,
  this.title,
  this.poster_path,
  this.vote_average,
  this.overview,
});

  factory Movie.fromJson(Map<String, dynamic> json)  {
    return Movie(
      id: json['id'] as int,
      title: json["title"] as String,
      poster_path: json["poster_path"],
      vote_average: double.parse(json["vote_average"].toString()),
      overview: json["overview"] as String,
    );
  }

  Map toMap() {
    Map<String,dynamic> map = {
      "id": id,
      "title": title,
      "poster_path": poster_path,
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
    return 'Movie{id: $id, title: $title, urlFoto $urlFoto}';
  }
}