import 'dart:convert';

import 'package:practica_final_2/models/models.dart';

class PopularResponse {
  PopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalMovies,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalMovies;

  factory PopularResponse.fromJson(String str) =>
      PopularResponse.fromMap(json.decode(str));

  factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalMovies: json["total_results"],
      );
}
