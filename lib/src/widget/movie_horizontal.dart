import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  MovieHorizontal({@required this.peliculas});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.20, // el 20% del contexto principal
      child: PageView(
        controller: PageController(
            initialPage: 1,
            viewportFraction:
                0.3), // se controla el deslizamiento y la cantidad de tarjetas a mostrar
        pageSnapping: false, //para respetar el momento al desplazar el Page
        children: _tarjetas(context),
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              // Cliprrect es para redondear el contenedor de las imagenes
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            SizedBox(),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();

    // Retorna una lista de Peliculas
    // peliculas.forEach((element) {
    //   final List<Pelicula> _peliculassss = new List();
    //   _peliculassss.add(element);
    //   return _peliculassss;
    //  })
  }
}
