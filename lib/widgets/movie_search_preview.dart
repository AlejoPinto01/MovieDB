import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';

//Widget de previsualizacion de la pelicula para el buscador
class SearchPreview extends StatelessWidget {
  Movie movie;
  SearchPreview({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //Abre la pagina de detalles de la pelicula seleccionada
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
      child: Container(
        height: 100,
        //Limitacion para que no salga el texto
        width: MediaQuery.of(context).size.width - 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 70,
                  height: 90,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 120,
                ),
                child: Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
