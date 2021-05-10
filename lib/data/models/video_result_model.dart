import 'package:miusu/domain/entities/video_entity.dart';

class VideoResultModel {
  int? id;
  List<VideoModel>? videos;

  VideoResultModel({
      this.id, 
      this.videos});

  VideoResultModel.fromJson(dynamic json) {
    id = json["id"];
    if (json["results"] != null) {
      videos = [];
      json["results"].forEach((v) {
        videos?.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    if (videos != null) {
      map["results"] = videos?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "533ec654c3a36854480003eb"
/// iso_639_1 : "en"
/// iso_3166_1 : "US"
/// key : "SUXWAEX2jlg"
/// name : "Trailer 1"
/// site : "YouTube"
/// size : 720
/// type : "Trailer"

class VideoModel extends VideoEntity{
  final String? id;
  final String? iso6391;
  final String? iso31661;
  final String key;
  final String name;
  final String? site;
  final int? size;
  final String type;

  VideoModel({
      this.id,
      this.iso6391, 
      this.iso31661, 
      required this.key,
      required this.name,
      this.site, 
      this.size, 
      required this.type}) : super (
    title: name,
    key: key,
    type: type,
  );

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id : json["id"],
      iso6391: json["iso_639_1"],
      iso31661: json["iso_3166_1"],
      key: json["key"],
      name: json["name"],
      site: json["site"],
      size: json["size"],
      type: json["type"],
    );

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["iso_639_1"] = iso6391;
    map["iso_3166_1"] = iso31661;
    map["key"] = key;
    map["name"] = name;
    map["site"] = site;
    map["size"] = size;
    map["type"] = type;
    return map;
  }

}