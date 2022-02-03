import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/casting_response.dart';

import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'b484e3e33832dcea7c4887cec5124533';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Cast> casting = [];

  MoviesProvider() {
    print('Provider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getPopularMovies() async {
    print('getPopularMovies');
    var url = Uri.https(_baseUrl, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    final result = await http.get(url);
    final popularResponse = PopularResponse.fromJson(result.body);

    popularMovies = popularResponse.results;

    notifyListeners();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getCasting(int movieId) async {
    //https://api.themoviedb.org/3/movie/634649/credits?api_key=b484e3e33832dcea7c4887cec5124533&language=en-US
    var url = Uri.https(_baseUrl, '/3/movie/${movieId}', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    final result = await http.get(url);
    final castingResponse = CastingResponse.fromJson(result.body);

    casting = castingResponse.cast;

    notifyListeners();
  }
}
