import 'dart:convert';

import 'package:deepbags/models/website.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebsiteModelRepository {
  @override
  String key = "websites";
  List<WebsiteModel> websites = [];
  @override
  saveToStorage(WebsiteModel model) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    List<WebsiteModel> websiteFilters = await listFromStorage();
    websiteFilters.add(model);
    prefs.setString(key, json.encode(WebsiteModel.listToJson(websiteFilters)));
    return true;
  }

  @override
  listFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<WebsiteModel> websiteFilters = [];
    String? filters = prefs.getString(key);
    if (filters != null) {
      websiteFilters = WebsiteModel.listFromJson(filters);
    }
    return websiteFilters;
  }
}
