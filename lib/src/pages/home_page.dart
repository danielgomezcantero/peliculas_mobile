import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

import 'package:peliculas/src/widget/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en Cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[Icon(Icons.search)],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas(),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    final peliculasProvider = new PeliculasProvider();
    peliculasProvider.getEnCines();

    return CardSwiper(peliculas: [1, 2, 3, 4, 5]);
  }
}
