class Actores {
  List<Actor> actoreslist = new List();

  Actores.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((actorJson) {
      final actorMapeado = new Actor.fromJsonMap(actorJson);

      actoreslist.add(actorMapeado);
    });
  }
}

class Actor {
  int id;
  String name;
  int order;
  int gender;
  int castId;
  String character;
  String creditId;
  String profilePath;

  Actor({
    this.id,
    this.name,
    this.order,
    this.gender,
    this.castId,
    this.character,
    this.creditId,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    gender = json['gender'];
    castId = json['cast_id'];
    creditId = json['credit_id'];
    character = json['character'];
    profilePath = json['profile_path'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://bizraise.pro/wp-content/uploads/2014/09/no-avatar-300x300.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
