import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/splashScreen.dart';

import 'Style/style.dart';

class TaskManagerApp extends StatelessWidget {

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey ,
      home: splashScreen(),

      theme: ThemeData(
        inputDecorationTheme:const InputDecorationTheme(
          fillColor: colorWhite,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
      ),
    );
  }
}
