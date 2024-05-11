import "package:deepbags/database/database.dart";
import "package:deepbags/layout.dart";
import "package:deepbags/screens/add_session.dart";
import "package:deepbags/screens/home.dart";
import "package:deepbags/screens/login.dart";
import "package:deepbags/screens/not_found.dart";
import "package:deepbags/screens/sessions.dart";
import "package:deepbags/screens/update_session.dart";
import "package:deepbags/widgets/loading.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

final router = GoRouter(routes: <RouteBase>[
  ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Layout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => GoogleLoginPage(),
        ),
        GoRoute(
            path: "/sessions",
            builder: (context, state) => const SessionsListPage(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => AddSessionPage(),
              ),
              GoRoute(
                  path: ':sessionId/update',
                  builder: (context, state) {
                    String? sessionId = state.pathParameters['sessionId'];
                    if (sessionId != null) {
                      var fetchSession =
                          sessionRepository.getSessionById(sessionId);
                      return FutureBuilder(
                          future: fetchSession,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ManageWebsitesPage(
                                  session: snapshot.data!);
                            } else if (snapshot.hasError) {
                              return const NotFoundPage();
                            }
                            return LoadingWidget();
                          });
                    }
                    return const NotFoundPage();
                  })
            ])
      ])
]);
