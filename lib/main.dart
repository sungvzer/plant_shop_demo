import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plant_shop_flutter/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Josefin Sans",
          colorSchemeSeed: Colors.lightGreen,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          fontFamily: "Josefin Sans",
          colorSchemeSeed: Colors.lightGreen,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
