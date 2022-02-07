import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              // Slider de pel·licules
              MovieSlider(movies: moviesProvider.popularMovies),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
            ],
          ),
        ),
      ),
    );
  }
}

//Barra de busqueda
class CustomSearchDelegate extends SearchDelegate {
  MoviesProvider moviesProvider = MoviesProvider();

  //Boton que limpiara la busqueda
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  //Boton para volver a la pantalla principal
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  //Mostrar la lista de resultados al enviar
  @override
  Widget buildResults(BuildContext context) {
    //Si no hay filtro de busqueda
    if (query.isEmpty) {
      return Center(
        child: Icon(
          Icons.movie,
          size: 200,
          color: Colors.grey,
        ),
      );
    } else {
      //Contruye la lista
      return FutureBuilder(
        //Recupera las peliculas con el fitro desde el provider
        future: moviesProvider.getFilter(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          //Si NO ha recibido informacion
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            //Guarda la info recuperada en una avar
            final movies = snapshot.data!;

            //Si la lista recuperada esta vacia
            if (movies.isEmpty) {
              //Avisa al usuario
              return Center(child: Text('No results for \"$query\"'));
            } else {
              //Construye la lista
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return SearchPreview(
                    movie: movies[index],
                  );
                },
              );
            }
          }
        },
      );
    }
  }

  //Previsualiza la lista de NowPlaying mientras escribe
  @override
  Widget buildSuggestions(BuildContext context) {
    //Si no hay filtro de busqueda
    if (query.isEmpty) {
      return Center(
        child: Icon(
          Icons.movie,
          size: 200,
          color: Colors.grey,
        ),
      );
    } else {
      //Inicializa una lista de pelis vacia
      List<Movie> previewMovies = [];

      //Recorre la lista de NowPlaying
      for (Movie movieP in moviesProvider.onDisplayMovies) {
        //Si coincide la busqueda con el titulo
        if (movieP.title.toLowerCase().contains(query.toLowerCase())) {
          //Añadela a la lista de previsualizacion
          previewMovies.add(movieP);
        }
      }

      //Si no encuentra coincidencias
      if (previewMovies.isEmpty) {
        //Necesita enviar para realizar la busqueda total
        return Center(child: Text('Search all movies...'));
      } else {
        //De lo contrario crea la lista de previsualizacion
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: previewMovies.length,
          itemBuilder: (BuildContext context, int index) {
            return SearchPreview(
              movie: previewMovies[index],
            );
          },
        );
      }
    }
  }
}
