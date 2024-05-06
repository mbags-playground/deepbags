import 'package:deepbags/database/models/website.dart';

enum Actions { addWebsite, removeWebsite, updateWebsite }

class AppState {
  List<Website> websites;
  AppState({required this.websites});
}

class WebsiteReducerAction {
  Actions type;
  Website payload;
  WebsiteReducerAction({required this.type, required this.payload});
}

AppState websiteReducer(AppState state, dynamic action) {
  switch (action.type) {
    case Actions.addWebsite:
      return AppState(websites: [...state.websites, action.payload]);
    case Actions.removeWebsite:
      return AppState(
          websites: state.websites
              .where((website) => website != action.payload)
              .toList());
    // case Actions.updateWebsite:
    //   return AppState(
    //       Websites: state.websites
    //           .map((Website) => Website == action.payload
    //               ? action.payload
    //               : Website)
    //           .toList());
    default:
      return state;
  }
}
