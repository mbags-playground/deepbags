// ignore_for_file: public_member_api_docs, sort_constructors_first
// Format of the data to have
// This app will create the proxy that will be used
import 'dart:convert';

import 'package:deepbags/models/base_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Obtain shared preferences.
enum FilterMode { allow, blow }

class WebsiteFilter implements AbstractModal {
  String? id;
  String name;
  DateTime? startTime;
  DateTime? endTime;
  FilterMode mode;
  String match;
  WebsiteFilter(
      {this.id,
      this.name = "",
      this.startTime,
      this.endTime,
      this.mode = FilterMode.blow,
      this.match = "*"}) {
    if (id == null) {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  @override
  Map<String, InputFieldOptions> getFieldsOptions() {
    return {
      "id": InputFieldOptions(label: 'Id', validators: []),
      "name": InputFieldOptions(label: 'Name'),
      "startTime": InputFieldOptions(label: 'Start Time'),
      "endTime": InputFieldOptions(label: 'End Time'),
      "match": InputFieldOptions(label: 'Regex match'),
      "mode": InputFieldOptions(label: 'Mode'),
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'match': match,
      'mode': mode,
    };
  }

  void saveToStorage() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    List<WebsiteFilter> websiteFilters = await WebsiteFilter.listFromStorage();
    websiteFilters.add(this);
    prefs.setString('filters', WebsiteFilter.listToJson(websiteFilters));
    // Save an integer value to 'counter' key.
  }

  factory WebsiteFilter.fromMap(Map<String, dynamic> map) {
    return WebsiteFilter(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
      startTime: DateTime.fromMicrosecondsSinceEpoch(map['startTime'] as int),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      match: map['match'] as String,
      mode: map['mode'] as FilterMode,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory WebsiteFilter.fromJson(String source) =>
      WebsiteFilter.fromMap(json.decode(source) as Map<String, dynamic>);
  static List<WebsiteFilter> listFromMap(List<Map<String, dynamic>> source) {
    return source.map((e) => WebsiteFilter.fromMap(e)).toList();
  }

  static List<WebsiteFilter> listFromJson(String source) {
    return WebsiteFilter.listFromMap(
        json.decode(source) as List<Map<String, dynamic>>);
  }

  static String listToJson(List<WebsiteFilter> source) {
    return json.encode(source.map((e) => e.toMap()).toList());
  }

  static Future<List<WebsiteFilter>> listFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<WebsiteFilter> websiteFilters = [];
    String? filters = prefs.getString('filters');
    if (filters != null) {
      websiteFilters = WebsiteFilter.listFromJson(filters);
    }
    return websiteFilters;
  }
}
