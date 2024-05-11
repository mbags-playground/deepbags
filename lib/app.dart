import 'package:deepbags/routes.dart';
import 'package:deepbags/theme.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deep bags',
      theme: themeData,
      darkTheme: ThemeData.dark(),
      routerConfig: router,
    );
  }
}
