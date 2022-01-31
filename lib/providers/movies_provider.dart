import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:practica_final_2/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'b484e3e33832dcea7c4887cec5124533';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovie = [];

  MoviesProvider() {
    print('Provider inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovie = nowPlayingResponse.movies;

    notifyListeners();
  }
}
