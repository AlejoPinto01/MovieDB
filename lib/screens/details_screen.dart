import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Peli
    //Pillamos la pelicula pasada como argumento de la pagina
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.id.toString());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //Se la pasamos a los diferentes widgets por parametro
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(movie: movie),
                _Overview(movie: movie),
                CastingCards(movieId: movie.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            movie.getMovieTitle, //Titulo de la pelicula en castellano
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath), //Imagen de backdrop
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitile({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(movie.fullPosterPath), //Poster pelicula
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 170,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.getMovieTitle, //Titulo pelicula en castellano
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.getOriginalTitle, //Titulo original pelicula
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(
                      width: 5,
                    ),
                    Text(movie.getVoteAverage.toString(),
                        style: textTheme.caption), //Valoracion pelicula
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({
    Key? key,
    required this.movie,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        movie.getOverview, //Sinopsis pelicula
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
