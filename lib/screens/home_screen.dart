import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/movie_search_preview.dart';
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
              // MovieSlider(),
              // MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Movie> movies = [];
  //List<String> searchTerms = [];
  MoviesProvider moviesProvider = MoviesProvider();

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

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Icon(
          Icons.movie,
          size: 200,
          color: Colors.grey,
        ),
      );
    } else {
      return FutureBuilder(
        future: moviesProvider.getFilter(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final movies = snapshot.data!;

            if (movies.isEmpty) {
              return Center(child: Text('No results for \"$query\"'));
            } else {
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

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Icon(
          Icons.movie,
          size: 200,
          color: Colors.grey,
        ),
      );
    } else {
      List<Movie> previewMovies = [];
      for (Movie movieP in moviesProvider.onDisplayMovies) {
        if (movieP.title.toLowerCase().contains(query.toLowerCase())) {
          previewMovies.add(movieP);
        }
      }

      if (previewMovies.isEmpty) {
        return Center(child: Text('Search all movies...'));
      } else {
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
