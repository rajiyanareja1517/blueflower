import 'package:blueflower/views/screens/add_screen.dart';
import 'package:blueflower/views/screens/details_screen.dart';
import 'package:blueflower/views/screens/home_screen.dart';
import 'package:blueflower/views/screens/login_screen.dart';
import 'package:blueflower/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';

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
      routes: {
        '/':(context)=>SplashScreen(),
        'home': (context) => HomeScreen(),
        'login': (context) => LoginScreen(),
        'detail': (context) => DetailsScreen(),
        'add': (context) => AddScreen()
      },
    );
  }
}
