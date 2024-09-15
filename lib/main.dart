import 'package:flutter/material.dart';
import 'package:food_waste_management/collector/view/login.dart';
import 'package:food_waste_management/donor/auth/view/login.dart';
import 'package:food_waste_management/starter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StarterScreen());
  }
}
