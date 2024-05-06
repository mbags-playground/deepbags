import 'dart:convert';

import 'package:deepbags/database/models/website.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebsiteRepository {
  @override
  String key = "websites";
  List<Website> websites = [];
  @override
  saveToStorage(Website model) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    List<Website> websiteFilters = await listFromStorage();
    websiteFilters.add(model);
    prefs.setString(key, json.encode(Website.listToJson(websiteFilters)));
    return true;
  }

  @override
  listFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<Website> websiteFilters = [];
    String? filters = prefs.getString(key);
    if (filters != null) {
      websiteFilters = Website.listFromJson(filters);
    }
    return websiteFilters;
  }
}
