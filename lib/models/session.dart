import 'dart:convert';
import 'package:deepbags/models/website.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:uuid/uuid.dart';
part "session.g.dart";

// Obtain shared preferences.
enum FilterMode { allow, block }

@JsonSerializable()
class SessionModel {
  String? id;
  String name;
  DateTime? startTime;
  int lengthInMinutes;
  FilterMode mode;
  List<WebsiteModel> websites;
  SessionModel({
    this.name = "",
    this.startTime,
    this.mode = FilterMode.block,
    this.id,
    this.lengthInMinutes = 60,
    this.websites = const [],
  }) {
    id ??= Uuid().v4();
  }
  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
  @override
  static List<Map<String, dynamic>> listToJson(List<SessionModel> source) {
    return source.map((e) => e.toJson()).toList();
  }

  static List<SessionModel> listFromMap(List<Map<String, dynamic>> source) {
    return source.map((e) => SessionModel.fromJson(e)).toList();
  }

  static List<SessionModel> listFromJson(String source) {
    return SessionModel.listFromMap(
        json.decode(source) as List<Map<String, dynamic>>);
  }
}
