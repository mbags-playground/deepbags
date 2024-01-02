import 'package:deepbags/models/website_filter.dart';

enum Actions { addWebsiteFilter, removeWebsiteFilter, updateWebsiteFilter }

class AppState {
  List<WebsiteFilter> websiteFilters;
  AppState({required this.websiteFilters});
}

class WebsiteFilterReducerAction {
  Actions type;
  WebsiteFilter payload;
  WebsiteFilterReducerAction({required this.type, required this.payload});
}

AppState websiteFilterReducer(AppState state, dynamic action) {
  switch (action.type) {
    case Actions.addWebsiteFilter:
      return AppState(
          websiteFilters: [...state.websiteFilters, action.payload]);
    case Actions.removeWebsiteFilter:
      return AppState(
          websiteFilters: state.websiteFilters
              .where((websiteFilter) => websiteFilter != action.payload)
              .toList());
    // case Actions.updateWebsiteFilter:
    //   return AppState(
    //       WebsiteFilters: state.websiteFilters
    //           .map((WebsiteFilter) => WebsiteFilter == action.payload
    //               ? action.payload
    //               : WebsiteFilter)
    //           .toList());
    default:
      return state;
  }
}
