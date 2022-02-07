import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'b484e3e33832dcea7c4887cec5124533';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> searchMovies = [];
  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print('Provider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  //Metodo que retorna una lista de Movies
  getPopularMovies() async {
    print('getPopularMovies');
    var url = Uri.https(_baseUrl, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    final result = await http.get(url);
    final popularResponse = MoviesResponse.fromJson(result.body);

    popularMovies = popularResponse.results;

    notifyListeners();
  }

  //Metodo que retorna una lista de Movies
  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    final result = await http.get(url);
    final nowPlayingResponse = MoviesResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  //Metodo que recibe un ID de Movie y devuelve un Future que construira la lista de actores por dicha Movie
  Future<List<Cast>> getCasting(int movieId) async {
    //concatena el ID a la URI
    var url = Uri.https(_baseUrl, '/3/movie/${movieId}/credits', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    final result = await http.get(url);
    final castingResponse = CastingResponse.fromJson(result.body);

    casting[movieId] = castingResponse.cast;

    return castingResponse.cast;
  }

  //Metodo que recibe la busqueda del usuario y devuelve un Future que construira la lista de peliculas que culplan con la busqueda
  Future<List<Movie>> getFilter(String filter) async {
    var url = Uri.https(_baseUrl, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
      'query': filter,
    });

    final result = await http.get(url);
    final searchResponse = MoviesResponse.fromJson(result.body);

    searchMovies = searchResponse.results;

    return searchResponse.results;
  }
}
