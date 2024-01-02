import "package:deepbags/screens/filters/add_filters.dart";
import "package:deepbags/screens/home.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

final router = GoRouter(routes: <RouteBase>[
  ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Scaffold(
          body: child,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
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
                    context.go('/add');
                  },
                  icon: const Icon(Icons.add),
                ),
                label: 'Filters',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    context.go('/add');
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
          path: '/add',
          builder: (context, state) => const AddFlitter(),
        ),
      ])
]);
