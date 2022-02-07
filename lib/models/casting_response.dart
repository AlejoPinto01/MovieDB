import 'models.dart';

class CastingResponse {
  CastingResponse({
    required this.id,
    required this.cast,
  });

  int id;
  List<Cast> cast;

  factory CastingResponse.fromJson(String str) =>
      CastingResponse.fromMap(json.decode(str));

  factory CastingResponse.fromMap(Map<String, dynamic> json) => CastingResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
      );
}
