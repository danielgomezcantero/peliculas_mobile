import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman ',
    'Spiderman 2',
    'Spiderman 3',
    'Ironman',
    'Ironman 2 ',
    'Capitan America',
  ];

  final peliculasRecientes = ['Superman', 'Hulk'];

  String seleccion = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    //las acciones de nuestro AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
        child: Container(
            height: 100.0,
            width: 100.0,
            child: Center(
              child: Text(
                seleccion,
                style: TextStyle(color: Colors.white),
              ),
            ),
            color: Colors.amber));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Las sugerencia que aparece cuando se escribe

    // #### Prueba de funcionamiento ###
    // final listaSugerida = (query.isEmpty)
    //     ? peliculasRecientes
    //     : peliculas // verifico si cada valor ingresa se encuentrar en la lista de las peliculas
    //         .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
    //         .toList();

    // return ListView.builder(
    //   itemCount: listaSugerida.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(listaSugerida[i]),
    //       onTap: () {
    //         seleccion = listaSugerida[i];
    //         //para mostrar el buildResults
    //         showResults(context);
    //       },
    //     );
    //   },
    // );

    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.buscarPeliculas(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculasData = snapshot.data;
          return ListView(
              children: peliculasData.map((peli) {
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  peli.getPosterImg(),
                ),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(peli.title),
              subtitle: Text(peli.originalTitle),
              onTap: () {
                close(context, null);
                Navigator.pushNamed(context, 'detalle', arguments: peli);
              },
            );
          }).toList());
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
