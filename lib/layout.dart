import 'package:deepbags/utils/isDarkMode.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavItem {
  IconData icon;
  String route;
  String label;
  NavItem({required this.icon, required this.route, required this.label});
}

class Layout extends StatefulWidget {
  Widget child;
  Layout({super.key, required this.child});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  String? themeMode;
  @override
  Widget build(BuildContext context) {
    themeMode = isDarkMode(context) ? 'dark' : 'light';
    var navItems = [
      NavItem(icon: Icons.home, route: '/', label: 'Home'),
      NavItem(icon: Icons.login, route: '/login', label: 'Login'),
      NavItem(
          icon: Icons.plus_one, route: '/sessions/add', label: 'Add sessions'),
      NavItem(icon: Icons.bookmark, route: '/sessions', label: 'Sessions'),
    ];
    return Scaffold(
      body: widget.child,
      floatingActionButton: IconButton(
          onPressed: () {
            setState(() {
              themeMode = themeMode == 'dark' ? 'light' : 'dark';
            });
          },
          icon: const Icon(Icons.circle)),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          context.go(navItems[index].route),
        },
        items: navItems
            .map((item) => BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(item.icon),
                    color: themeMode == 'dark' ? Colors.white : Colors.black,
                    onPressed: () {
                      context.go('/');
                    },
                  ),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }
}
