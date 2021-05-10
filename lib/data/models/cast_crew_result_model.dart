import 'package:miusu/domain/entities/cast_entity.dart';

class CastCrewResultModel {
  int? id;
  List<CastModel>? cast;
  List<Crew>? crew;

  CastCrewResultModel({
      this.id,
      this.cast,
      this.crew});

  CastCrewResultModel.fromJson(dynamic json) {
    id = json["id"];
    if (json["cast"] != null) {
      cast = [];
      json["cast"].forEach((v) {
        cast?.add(CastModel.fromJson(v));
      });
    }
    if (json["crew"] != null) {
      crew = [];
      json["crew"].forEach((v) {
        crew?.add(Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    if (cast != null) {
      map["cast"] = cast?.map((v) => v.toJson()).toList();
    }
    if (crew != null) {
      map["crew"] = crew?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// adult : false
/// gender : 2
/// id : 376
/// known_for_department : "Production"
/// name : "Arnon Milchan"
/// original_name : "Arnon Milchan"
/// popularity : 1.702
/// profile_path : "/b2hBExX4NnczNAnLuTBF4kmNhZm.jpg"
/// credit_id : "55731b8192514111610027d7"
/// department : "Production"
/// job : "Executive Producer"

class Crew {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

  Crew({
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.creditId,
      this.department,
      this.job});

  Crew.fromJson(dynamic json) {
    adult = json["adult"];
    gender = json["gender"];
    id = json["id"];
    knownForDepartment = json["known_for_department"];
    name = json["name"];
    originalName = json["original_name"];
    popularity = json["popularity"];
    profilePath = json["profile_path"];
    creditId = json["credit_id"];
    department = json["department"];
    job = json["job"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["adult"] = adult;
    map["gender"] = gender;
    map["id"] = id;
    map["known_for_department"] = knownForDepartment;
    map["name"] = name;
    map["original_name"] = originalName;
    map["popularity"] = popularity;
    map["profile_path"] = profilePath;
    map["credit_id"] = creditId;
    map["department"] = department;
    map["job"] = job;
    return map;
  }

}

/// adult : false
/// gender : 2
/// id : 819
/// known_for_department : "Acting"
/// name : "Edward Norton"
/// original_name : "Edward Norton"
/// popularity : 7.861
/// profile_path : "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg"
/// cast_id : 4
/// character : "The Narrator"
/// credit_id : "52fe4250c3a36847f80149f3"
/// order : 0

class CastModel extends CastEntity{
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final int? order;

  CastModel({
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      required this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      required this.creditId,
      this.order}) : super(
    name: name!,
    creditId: creditId,
    profilePath: profilePath,
    character: character
  );

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'],
      adult: json['adult'],
      gender: json['gender'],
      id: json['id'],
      knownForDepartment: json["known_for_department"],
      originalName: json["original_name"],
      popularity: json["popularity"],
      profilePath: json["profile_path"],
      castId: json["cast_id"],
      character: json["character"],
      creditId: json["credit_id"],
      order: json["order"],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["adult"] = adult;
    map["gender"] = gender;
    map["id"] = id;
    map["known_for_department"] = knownForDepartment;
    map["name"] = name;
    map["original_name"] = originalName;
    map["popularity"] = popularity;
    map["profile_path"] = profilePath;
    map["cast_id"] = castId;
    map["character"] = character;
    map["credit_id"] = creditId;
    map["order"] = order;
    return map;
  }

}