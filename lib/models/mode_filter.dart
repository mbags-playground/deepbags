// ignore_for_file: public_member_api_docs, sort_constructors_first
// Format of the data to have
// This app will create the proxy that will be used
import 'dart:convert';

import 'package:deepbags/models/base_model.dart';
import 'package:deepbags/models/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Obtain shared preferences.
enum FilterMode { allow, blow }

class ModeFilter extends BaseModel {
  String? id;
  String name;
  DateTime startTime;
  String endTime;
  List<String>? repeatDays;
  FilterMode mode;

  Map<String, InputFieldOptions> _inputFieldsOptions = {};

  ModeFilter(
      {required this.name,
      required this.endTime,
      required this.startTime,
      required this.mode,
      this.repeatDays,
      this.id,
      super.key = "ModeFilter"}) {
    if (id == null) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }
    _inputFieldsOptions = {
      "id": InputFieldOptions(label: 'Id', validators: []),
      "name": InputFieldOptions(label: 'Name'),
      "startTime": InputFieldOptions(label: 'Start time'),
      "endTime": InputFieldOptions(label: 'End time'),
      "repeatDays": InputFieldOptions(label: 'Repeat days'),
      "mode": InputFieldOptions(label: 'Mode'),
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      "repeatDays": repeatDays,
      "mode": mode
    };
  }

  void saveToStorage() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    List<ModeFilter> modeFilters = await ModeFilter.listFromStorage();
    modeFilters.add(this);
    prefs.setString('filters', ModeFilter.listToJson(modeFilters));
    // Save an integer value to 'counter' key.
  }

  static String listToJson(List<ModeFilter> source) {
    return json.encode(source.map((e) => e.toMap()).toList());
  }

  factory ModeFilter.fromMap(Map<String, dynamic> map) {
    return ModeFilter(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as String,
      repeatDays: map['repeatDays'] as List<String>,
      mode: map['mode'] as FilterMode,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ModeFilter.fromJson(String source) =>
      ModeFilter.fromMap(json.decode(source) as Map<String, dynamic>);
  static List<ModeFilter> listFromMap(List<Map<String, dynamic>> source) {
    return source.map((e) => ModeFilter.fromMap(e)).toList();
  }

  static List<ModeFilter> listFromJson(String source) {
    return ModeFilter.listFromMap(
        json.decode(source) as List<Map<String, dynamic>>);
  }

  static Future<List<ModeFilter>> listFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<ModeFilter> modeFilters = [];
    String? filters = prefs.getString('filters');
    if (filters != null) {
      modeFilters = ModeFilter.listFromJson(filters);
    }
    return modeFilters;
  }

  @override
  Map<String, InputFieldOptions> getFieldsOptions() {
    return _inputFieldsOptions;
  }

  updateFieldsOptions(Map<String, InputFieldOptions> targetedFieldsOptions) {
    _inputFieldsOptions = AbstractModel.mergeToInputOptions(
            input: getFieldsOptions(), target: targetedFieldsOptions) ??
        {};
  }
}
