import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/splashScreen.dart';

import 'Style/style.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
