import 'package:app/theme.dart';
import 'package:app/ui/home/home.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          titleMedium: deafaultTextStyle.apply(color: LightThemeColors.secondarytextColor),
          bodyMedium: deafaultTextStyle,
          headlineLarge: deafaultTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22
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
          surface: Colors.white,
          onSurface: LightThemeColors.secondaryColor,
        ),
      ),
      home: Directionality(textDirection: TextDirection.rtl, child:const HomeScreen()),
    );
  }
}
