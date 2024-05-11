import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part "website.g.dart";

@JsonSerializable()
class WebsiteModel {
  @Id()
  int? id = Isar.autoIncrement;
  String name;
  String match;
  WebsiteModel({this.id, this.name = "", this.match = "*"});
  factory WebsiteModel.fromJson(Map<String, dynamic> json) =>
      _$WebsiteModelFromJson(json);

  Map<String, dynamic> toJson() => _$WebsiteModelToJson(this);

  static List<WebsiteModel> listFromMap(List<Map<String, dynamic>> source) {
    return source.map((e) => WebsiteModel.fromJson(e)).toList();
  }

  static List<WebsiteModel> listFromJson(String source) {
    return WebsiteModel.listFromMap(
        json.decode(source) as List<Map<String, dynamic>>);
  }

  static List<Map<String, dynamic>> listToJson(List<WebsiteModel> source) {
    return source.map((e) => e.toJson()).toList();
  }
}
