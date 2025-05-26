import 'package:flutter/material.dart';
import 'package:plant_watering_reminder/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Watering Reminder',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.lightGreen,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.lime),
      ),
      home: const HomeScreen(),
    );
  }
}
