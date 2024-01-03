import 'dart:convert';

import 'package:deepbags/models/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractModel {
  Map<String, InputFieldOptions>? getFieldsOptions();
  void saveToStorage();

  static Map<String, InputFieldOptions>? mergeToInputOptions(
      {required Map<String, InputFieldOptions> input,
      required Map<String, InputFieldOptions> target}) {
    if (input != null) {
      for (String? key in target.keys) {
        // merge targetedFieldsOptions with inputFields
        if (input.containsKey(key)) {
          input[key!] = target[key]!;
        }
      }
    }
    return input;
  }

  Map<String, dynamic>? toMap();
  String toJson();
}

class BaseModel implements AbstractModel {
  String key = "BaseModel";

  Map<String, InputFieldOptions> _inputFieldsOptions = {};
  BaseModel({required this.key});

  static String listToJson(List<BaseModel> source) {
    return json.encode(source.map((e) => e.toMap()).toList());
  }

  void saveToStorage() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    List<BaseModel> list = await BaseModel.listFromStorage();
    list.add(this);
    prefs.setString(this.key, BaseModel.listToJson(list));
    // Save an integer value to 'counter' key.
  }

  static Future<List<BaseModel>> listFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<BaseModel> modeFilters = [];
    String? filters = prefs.getString('filters');
    if (filters != null) {
      modeFilters = BaseModel.listFromJson(filters);
    }
    return modeFilters;
  }

  static List<BaseModel> listFromJson(String source) {
    return BaseModel.listFromMap(
        json.decode(source) as List<Map<String, dynamic>>);
  }

  factory BaseModel.fromMap(Map<String, dynamic> map) {
    return BaseModel(key: "ModeFilter");
  }

  static List<BaseModel> listFromMap(List<Map<String, dynamic>> source) {
    return source.map((e) => BaseModel.fromMap(e)).toList();
  }

  Map<String, InputFieldOptions> getFieldsOptions() {
    return _inputFieldsOptions;
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic>? toMap() {
    return {};
  }
}
