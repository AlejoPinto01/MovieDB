// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromMap(jsonString);

import 'models.dart';

class NowPlayingResponse {
  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalMovies,
  });

  Dates dates;
  int page;
  List<Movie> movies;
  int totalPages;
  int totalMovies;

  factory NowPlayingResponse.fromJson(String str) =>
      NowPlayingResponse.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory NowPlayingResponse.fromMap(Map<String, dynamic> json) =>
      NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        movies: List<Movie>.from(json["movies"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalMovies: json["total_movies"],
      );

  // Map<String, dynamic> toMap() => {
  //       "dates": dates.toMap(),
  //       "page": page,
  //       "movies": List<dynamic>.from(movies.map((x) => x.toMap())),
  //       "total_pages": totalPages,
  //       "total_movies": totalMovies,
  //     };
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toMap() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
