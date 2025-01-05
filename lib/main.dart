import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_tracker_app/home.dart';
import 'package:task_tracker_app/provider/task_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Tracker App',
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}
