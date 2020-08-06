import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiperFooter extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiperFooter({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screnSize = MediaQuery.of(context).size;
    return Container(
      child: Swiper(
        itemHeight: 200.0,
        itemWidth: _screnSize.width * 0.5,
        itemBuilder: (context, int index) {
          return FadeInImage(
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(peliculas[index].getPosterImg()));
        },

        itemCount: peliculas.length,
        //viewportFraction: 0.8,
        //scale: 0.9,
        layout: SwiperLayout.TINDER,
      ),
    );
  }
}
