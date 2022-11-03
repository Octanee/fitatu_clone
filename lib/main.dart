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
      home: FitatuCloneAppView(),
    );
  }
}

class FitatuCloneAppView extends StatelessWidget {
  const FitatuCloneAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('FitatuCloneApp'),
      ),
    );
  }
}
