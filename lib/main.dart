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
    // const seedColor = Color(0xffC7F2A7);
    const seedColor = Color(0xffD3FCD5);
    return ProviderScope(
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Josefin Sans",
          colorSchemeSeed: seedColor,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          fontFamily: "Josefin Sans",
          colorSchemeSeed: seedColor,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
