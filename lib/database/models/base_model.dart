import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BaseModel {
  String key = "BaseModel";

  BaseModel({required this.key});

  static Future<List<BaseModel>> listFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<BaseModel> modeFilters = [];
    String? filters = prefs.getString('filters');
    if (filters != null) {
      modeFilters = BaseModel.listFromJson(filters);
    }
    return modeFilters;
  }

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      BaseModel(key: "BaseModel");

  static List<BaseModel> listFromJson(String source) {
    return BaseModel.listFromMap(
        json.decode(source) as List<Map<String, dynamic>>);
  }

  static List<BaseModel> listFromMap(List<Map<String, dynamic>> source) {
    return source.map((e) => BaseModel.fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() => {};
}
