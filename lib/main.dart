import 'package:fitatu_clone/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FitatuCloneApp());
}

class FitatuCloneApp extends StatelessWidget {
  const FitatuCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
