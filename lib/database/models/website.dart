// ignore_for_file: public_member_api_docs, sort_constructors_first
// Format of the data to have
// This app will create the proxy that will be used

import 'dart:convert';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "base_model.dart";
part 'website.g.dart';

@JsonSerializable()
@Collection()
@CopyWith()
class Website extends BaseModel {
  @Id()
  int? id = Isar.autoIncrement;
  String name;
  String match;
  Website({this.id, this.name = "", this.match = "*"}) : super(key: "website");
  factory Website.fromJson(Map<String, dynamic> json) =>
      _$WebsiteFromJson(json);

  Map<String, dynamic> toJson() => _$WebsiteToJson(this);

  static List<Website> listFromMap(List<Map<String, dynamic>> source) {
    return source.map((e) => Website.fromJson(e)).toList();
  }

  static List<Website> listFromJson(String source) {
    return Website.listFromMap(
        json.decode(source) as List<Map<String, dynamic>>);
  }

  static List<Map<String, dynamic>> listToJson(List<Website> source) {
    return source.map((e) => e.toJson()).toList();
  }
}
// Obtain shared preferences.
