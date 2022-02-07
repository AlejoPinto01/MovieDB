import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    //Contruccion de la lista
    return FutureBuilder(
      //Recupera el Future de la lista de actores del proveedor
      future: moviesProvider.getCasting(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        //Si NO recupera contenido
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              //Mostrar carga
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          //Guardar la informacion recuperada en una variable
          final casting = snapshot.data!;

          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            //Contruye una lista de los actores recuperados
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: casting.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) =>
                  _CastCard(actor: casting[index]),
            ),
          );
        }
      },
    );
  }
}

//Carta para cada actor individual que compondra la lista
class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.getFullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            actor.getActorName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
