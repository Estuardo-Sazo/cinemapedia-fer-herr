import 'movie_moviedb.dart';

/* MovieDbResponse movieDbResponseFromJson(String str) =>
    MovieDbResponse.fromJson(json.decode(str));

String movieDbResponseToJson(MovieDbResponse data) =>
    json.encode(data.toJson()); */

class MovieDbResponse {
  final Dates? dates;
  final int page;
  final List<MOvieMovieDB> MOvieMovieDBs;
  final int totalPages;
  final int totalMOvieMovieDBs;

  MovieDbResponse({
    required this.dates,
    required this.page,
    required this.MOvieMovieDBs,
    required this.totalPages,
    required this.totalMOvieMovieDBs,
  });

  factory MovieDbResponse.fromJson(Map<String, dynamic> json) =>
      MovieDbResponse(
        dates: json["dates"] ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        MOvieMovieDBs: List<MOvieMovieDB>.from(
            json["MOvieMovieDBs"].map((x) => MOvieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalMOvieMovieDBs: json["total_MOvieMovieDBs"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates == null ? null : dates!.toJson(),
        "page": page,
        "MOvieMovieDBs":
            List<dynamic>.from(MOvieMovieDBs.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_MOvieMovieDBs": totalMOvieMovieDBs,
      };
}

class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
