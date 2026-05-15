import 'package:app/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const deafaultTextStyle = TextStyle(
      fontFamily: 'Yekan',
      color: LightThemeColors.primarytextColor,
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: deafaultTextStyle,
          headlineLarge: deafaultTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
          bodySmall: deafaultTextStyle.copyWith(
            color: LightThemeColors.secondarytextColor,
          ),
        ),
        colorScheme: ColorScheme(
          primary: LightThemeColors.primarycolor,
          secondary: LightThemeColors.secondaryColor,
          brightness: Brightness.light,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          error: Colors.white,
          onError: Colors.red,
          surface: LightThemeColors.primarycolor,
          onSurface: LightThemeColors.secondaryColor,
        ),
      ),
      home: Directionality(textDirection: TextDirection.rtl, child: Home()),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
