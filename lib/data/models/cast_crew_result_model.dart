import 'package:miusu/domain/entities/cast_entity.dart';

class CastCrewResultModel {
  int id;
  List<CastModel> cast;
  List<Crew> crew;

  CastCrewResultModel({
      required this.id,
      required this.cast,
    required this.crew});

  factory CastCrewResultModel.fromJson(dynamic json) {
    var cast = List<CastModel>.empty(growable: true);
    var crew = List<Crew>.empty(growable: true);
    if (json['cast'] != null) {
      json['cast'].forEach((v) {
        final castModel = CastModel.fromJson(v);
        if (_isValidCast(castModel)) {
          cast.add(CastModel.fromJson(v));
        }
      });
    }
    if (json['crew'] != null) {
      json['crew'].forEach((v) {
        final crewModel = Crew.fromJson(v);
        if (_isValidCrew(crewModel)) {
          crew.add(crewModel);
        }
      });
    }

    return CastCrewResultModel(
      id: json['id'],
      cast: cast,
      crew: crew,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cast'] = this.cast.map((v) => v.toJson()).toList();
    data['crew'] = this.crew.map((v) => v.toJson()).toList();
    return data;
  }

}
bool _isValidCast(CastModel castModel) {
  return castModel.creditId.isNotEmpty &&
      castModel.character.isNotEmpty &&
      castModel.name.isNotEmpty &&
      castModel.profilePath.isNotEmpty;
}

bool _isValidCrew(Crew crewModel) {
  return crewModel.creditId.isNotEmpty &&
      crewModel.department.isNotEmpty &&
      crewModel.name.isNotEmpty &&
      crewModel.profilePath.isNotEmpty;
}

class Crew {
  late int? gender;
  late int? id;
  late String name;
  late String profilePath;
  late String creditId;
  late String department;
  late String? job;

  Crew({
      this.gender,
      this.id,
      required this.name,
      required this.profilePath,
      required this.creditId,
      required this.department,
      this.job});

  Crew.fromJson(dynamic json) {
    gender = json["gender"] ?? '';
    id = json["id"];
    name = json["name"];
    profilePath = json["profile_path"] ?? '';
    creditId = json["credit_id"] ?? '';
    department = json["department"] ?? '';
    job = json["job"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["gender"] = gender;
    map["id"] = id;
    map["name"] = name;
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
  final int? gender;
  final int? id;
  final String name;
  final String profilePath;
  final int? castId;
  final String character;
  final String creditId;
  final int? order;

  CastModel({
      this.gender,
      this.id,
      required this.name,
      required this.profilePath,
      this.castId,
      required this.character,
      required this.creditId,
      this.order}) : super(
    name: name,
    creditId: creditId,
    profilePath: profilePath,
    character: character
  );

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? '',
      gender: json['gender'],
      id: json['id'],
      profilePath: json["profile_path"] ?? '',
      castId: json["cast_id"],
      character: json["character"] ?? '',
      creditId: json["credit_id"] ?? '',
      order: json["order"],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["gender"] = gender;
    map["id"] = id;
    map["name"] = name;
    map["profile_path"] = profilePath;
    map["cast_id"] = castId;
    map["character"] = character;
    map["credit_id"] = creditId;
    map["order"] = order;
    return map;
  }

}