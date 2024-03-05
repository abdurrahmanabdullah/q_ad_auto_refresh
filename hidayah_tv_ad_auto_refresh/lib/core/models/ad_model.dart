// To parse this JSON data, do
//
//     final adModel = adModelFromJson(jsonString);

import 'dart:convert';

AdModel adModelFromJson(String str) => AdModel.fromJson(json.decode(str));

String adModelToJson(AdModel data) => json.encode(data.toJson());

class AdModel {
  List<Datum>? data;
  String? updateAt;

  AdModel({
    this.data,
    this.updateAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        updateAt: json["update_at"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "update_at": updateAt,
      };
}

class Datum {
  AddTypes? addTypes;
  String? createAt;
  bool? datumDefault;
  bool? doubleStatus;
  String? doubleType;
  String? duration;
  dynamic endTime;
  int? id;
  dynamic multiSide;
  bool? multiSlideStatus;
  dynamic multiTopBottom;
  dynamic multiType;
  String? name;
  String? serial;
  dynamic startTime;
  bool? status;
  dynamic thumnil;
  String? uuid;

  Datum({
    this.addTypes,
    this.createAt,
    this.datumDefault,
    this.doubleStatus,
    this.doubleType,
    this.duration,
    this.endTime,
    this.id,
    this.multiSide,
    this.multiSlideStatus,
    this.multiTopBottom,
    this.multiType,
    this.name,
    this.serial,
    this.startTime,
    this.status,
    this.thumnil,
    this.uuid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        addTypes: addTypesValues.map[json["addTypes"]]!,
        createAt: json["createAt"],
        datumDefault: json["default"],
        doubleStatus: json["doubleStatus"],
        doubleType: json["doubleType"],
        duration: json["duration"],
        endTime: json["endTime"],
        id: json["id"],
        multiSide: json["multiSide"],
        multiSlideStatus: json["multiSlideStatus"],
        multiTopBottom: json["multiTopBottom"],
        multiType: json["multiType"],
        name: json["name"],
        serial: json["serial"],
        startTime: json["startTime"],
        status: json["status"],
        thumnil: json["thumnil"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "addTypes": addTypesValues.reverse[addTypes],
        "createAt": createAt,
        "default": datumDefault,
        "doubleStatus": doubleStatus,
        "doubleType": doubleType,
        "duration": duration,
        "endTime": endTime,
        "id": id,
        "multiSide": multiSide,
        "multiSlideStatus": multiSlideStatus,
        "multiTopBottom": multiTopBottom,
        "multiType": multiType,
        "name": name,
        "serial": serial,
        "startTime": startTime,
        "status": status,
        "thumnil": thumnil,
        "uuid": uuid,
      };
}

enum AddTypes { banner, embedVideo, video }

final addTypesValues = EnumValues({"banner": AddTypes.banner, "embedVideo": AddTypes.embedVideo, "video": AddTypes.video});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
