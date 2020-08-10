import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = '6cee1ce91f2e73cbad51cc7a92f2c6bb';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _peliculasPopulares = 0;

  bool _cargando = false;

  List<Pelicula> _popularesList = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  //Get para agregar peliculas al flujo
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  // Get para escuchar nuevas peliculas
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void _disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);

    final decodedData = jsonDecode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;

    _peliculasPopulares++;

    print('Cargando siguientes....');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _peliculasPopulares.toString()
    });

    // final resp = await http.get(url);
    // final decodedData = jsonDecode(resp.body);
    // final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    // return peliculas.items;

    final resp = await _procesarRespuesta(url);
    // obtengo la lista de peliculas y las agrego al nueva lista.

    _popularesList.addAll(resp);
    popularesSink(_popularesList);

    _cargando = false;

    return resp;
  }

  Future<List<Actor>> getActores(String peliculaId) async {
    final url = Uri.https(_url, '3/movie/$peliculaId/credits',
        {'api_key': _apikey, 'language': _language});

    final resp = await http.get(url);

    final dataDecoded = jsonDecode(resp.body);

    final actores = Actores.fromJsonList(dataDecoded['cast']);

    return actores.actoreslist;
  }

  Future<List<Pelicula>> buscarPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    return await _procesarRespuesta(url);
  }
}
