import 'package:flutter/material.dart';
import 'package:super90/view/homescreen.dart';
import 'package:super90/view/app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 190, 10, 82),
        ),
        useMaterial3: true,
      ),
      home: AppScreen(),
    );
  }
}
