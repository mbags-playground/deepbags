import 'dart:convert';

import 'package:deepbags/database/models/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepository {
  String key = "sessions";
  List<SessionModel> sessions = [];
  saveToStorage(SessionModel model) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    sessions = await listFromStorage();
    sessions.add(model);
    prefs.setString(key, json.encode(SessionModel.listToJson(sessions)));
    return true;
  }

  updateSession(SessionModel model) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    sessions = await listFromStorage();
    sessions = sessions.map((session) {
      if (session.id == model.id) {
        session = model;
      }
      return session;
    }).toList();

    prefs.setString(key, json.encode(SessionModel.listToJson(sessions)));
    return true;
  }

  Future<SessionModel> getSessionById(int id) async {
    sessions = await listFromStorage();
    return sessions.where((session) => session.id == id).first;
  }

  removeSession(SessionModel model) async {
    final prefs = await SharedPreferences.getInstance();
    sessions = await listFromStorage();
    sessions.removeWhere((session) => session.id == model.id);
    prefs.setString(key, json.encode(SessionModel.listToJson(sessions)));
    return true;
  }

  Future<List<SessionModel>> listFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<SessionModel> websiteFilters = [];
    String? filters = prefs.getString(key);
    if (filters != null) {
      websiteFilters = SessionModel.listFromJson(filters);
    }
    return websiteFilters;
  }
}
