import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  //Referencia de la función enviada desde el padre para instanciarla en el pageController
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _pageController =
        new PageController(initialPage: 1, viewportFraction: 0.3);

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        // print('Carga siguiente página de peliculas');
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.20, // el 20% del contexto principal
      child: PageView.builder(
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          return tarjeta(context, this.peliculas[index]);
        },
        controller:
            _pageController, // se controla el deslizamiento y la cantidad de tarjetas a mostrar
        pageSnapping: false, //para respetar el momento al desplazar el Page
        //children: _tarjetas(context),
      ),
    );
  }

  Widget tarjeta(BuildContext context, Pelicula pelicula) {
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
              height: 120.0,
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
  }

//metodo utilizado con el PageView
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
                height: 120.0,
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
