import 'package:flutter/material.dart';
import 'package:super90/constants/app_colors.dart';
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
        // Define the color scheme
        colorScheme: const ColorScheme(
          primary: AppColors.ligthBlue,
          secondary: AppColors.lightPink,
          surface: AppColors.white,
          background: AppColors.darkBgColor,
          error: Colors.red,
          onPrimary: AppColors.white,
          onSecondary: AppColors.white,
          onSurface: AppColors.black,
          onBackground: AppColors.white,
          onError: AppColors.white,
          brightness: Brightness.dark,
        ),
        // Define the default text theme
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.white),
          bodyMedium: TextStyle(color: AppColors.white),
          displayLarge: TextStyle(color: AppColors.white),
          displayMedium: TextStyle(color: AppColors.white),
          displaySmall: TextStyle(color: AppColors.white),
          headlineMedium: TextStyle(color: AppColors.white),
          headlineSmall: TextStyle(color: AppColors.white),
          titleLarge: TextStyle(color: AppColors.white),
          titleMedium: TextStyle(color: AppColors.white),
          titleSmall: TextStyle(color: AppColors.white),
          bodySmall: TextStyle(color: AppColors.white),
          labelLarge: TextStyle(color: AppColors.white),
          labelSmall: TextStyle(color: AppColors.white),
        ),
        // Define the default app bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.ligthBlue,
          foregroundColor: AppColors.white,
        ),
        // Define the default button theme
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.lightGreen,
          textTheme: ButtonTextTheme.primary,
        ),
        // Define the default input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightGreen,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        // Define the default floating action button theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.lightPink,
          foregroundColor: AppColors.white,
        ),
        // Define other theme properties if needed
        useMaterial3: true,
      ),
      home: AppScreen(),
    );
  }
}
