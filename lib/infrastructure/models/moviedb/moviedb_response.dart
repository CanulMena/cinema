import 'package:cinema/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieDbResponse {
    final Dates? dates;
    final int page;
    final List<MovieMovieDB> results;
    final int totalPages;
    final int totalResults;

    MovieDbResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });
    //haremos uso de un metodo constructor con nombre
                                    //*Este mapa es un mapa enorme que contiene toda la lista de peliculas que estan en la cartelera
    factory MovieDbResponse.fromJson(Map<String, dynamic> json) => MovieDbResponse(//convierto la peticion http a este tipo de dato que en este caso es MoiveDbResponse de esta forma si cambia el tipo de dato de la api lo cambiamos aquí
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieMovieDB>.from(json["results"].map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => { //Convierto el tipo de dato a un json
        "dates": dates == null ? null : dates!.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
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
        "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
    };
}
