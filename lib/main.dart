import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(centerTitle: true, titleTextStyle: GoogleFonts.bungee(fontSize: 27)),
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.bungeeTextTheme(TextTheme(
            bodyLarge: TextStyle(fontSize: 100, color: Colors.white),
            bodyMedium: TextStyle(fontSize: 75, color: Colors.white),
            bodySmall: TextStyle(fontSize: 30, color: Colors.white))),
      ),
      home: const GameScreen(),
    );
  }
}
