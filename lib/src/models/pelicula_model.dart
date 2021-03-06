// Generated by https://quicktype.io

class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);

      items.add(pelicula);
    }
  }
}

class Pelicula {
  int id;
  bool video;
  bool adult;
  String title;
  String overview;
  List<int> genreIds;
  int voteCount;
  double popularity;
  String posterPath;
  double voteAverage;
  String backdropPath;
  String originalTitle;
  String releaseDate;
  String originalLanguage;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    adult = json['adult'];
    title = json['title'];
    genreIds = json['genre_ids'].cast<int>();
    overview = json['overview'];
    voteCount = json['vote_count'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'] / 1;
    releaseDate = json['release_date'];
    backdropPath = json['backdrop_path'];
    originalTitle = json['original_title'];
    originalLanguage = json['original_language'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://sciences.ucf.edu/psychology/wp-content/uploads/sites/63/2019/09/No-Image-Available.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackdropImg() {
    if (backdropPath == null) {
      return 'https://sciences.ucf.edu/psychology/wp-content/uploads/sites/63/2019/09/No-Image-Available.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
