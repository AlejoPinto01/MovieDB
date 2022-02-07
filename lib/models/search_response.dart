import 'dart:convert';

import 'package:practica_final_2/models/models.dart';

class SearchResponse {
  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalMovies,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalMovies;

  factory SearchResponse.fromJson(String str) =>
      SearchResponse.fromMap(json.decode(str));

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalMovies: json["total_results"],
      );
}
