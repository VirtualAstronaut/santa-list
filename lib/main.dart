import 'package:flutter/material.dart';
import 'package:santa_list/feature/santa_list/view/santa_list_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.redAccent.shade200,
      ),
      home: const SantaListPage(),
    );
  }
}
