// To parse this JSON data, do
//
//     final castingResponse = castingResponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class CastingResponse {
  CastingResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory CastingResponse.fromJson(String str) =>
      CastingResponse.fromMap(json.decode(str));

  factory CastingResponse.fromMap(Map<String, dynamic> json) => CastingResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
      );
}
