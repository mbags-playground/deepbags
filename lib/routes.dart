import "package:deepbags/screens/home.dart";
import "package:deepbags/screens/session/add_session.dart";
import "package:deepbags/screens/session/view_filters.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

final router = GoRouter(routes: <RouteBase>[
  ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    context.go('/');
                  },
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    context.go('/filters/add');
                  },
                  icon: const Icon(Icons.add),
                ),
                label: 'Sessions',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    context.go('/filters/all');
                  },
                  icon: const Icon(Icons.settings),
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/filters/add',
          builder: (context, state) => const AddSession(),
        ),
        GoRoute(
          path: '/filters/all',
          builder: (context, state) => const AllSessions(),
        )
      ])
]);
