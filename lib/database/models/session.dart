import 'dart:convert';
import 'dart:math';

import 'package:deepbags/database/models/base_model.dart';
import 'package:deepbags/database/models/website.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part "session.g.dart";

// Obtain shared preferences.
enum FilterMode { allow, block }

@JsonSerializable()
class SessionModel extends BaseModel {
  int? id;
  String name;
  DateTime? startTime;
  int lengthInMinutes;
  FilterMode mode;
  List<Website> websites;
  SessionModel(
      {this.name = "",
      this.startTime,
      this.mode = FilterMode.block,
      this.id,
      this.lengthInMinutes = 60,
      this.websites = const [],
      super.key = "SessionModel"}) {
    id ??= Random.secure().nextInt(100000);
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
