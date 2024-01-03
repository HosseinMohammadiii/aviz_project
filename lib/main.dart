import 'package:aviz_project/screen/login_screen.dart';
import 'package:aviz_project/screen/register_feature_screen.dart';
import 'package:aviz_project/widgets/buttomnavigationbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationScreen(),
    );
  }
}
//LogInScreen(),