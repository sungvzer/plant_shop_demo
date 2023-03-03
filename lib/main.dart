import 'package:flutter/material.dart';
import 'package:plant_shop_flutter/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
