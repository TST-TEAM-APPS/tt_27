import 'package:flutter/material.dart';
import 'package:tt_27/bottom_navigation_bar/bottom_navigation_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomNavigationBar(),
    );
  }
}
