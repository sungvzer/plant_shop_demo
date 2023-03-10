import 'package:go_router/go_router.dart';
import 'package:plant_shop_flutter/pages/cart_page.dart';
import 'package:plant_shop_flutter/pages/home_page.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        path: 'cart',
        builder: (context, state) => const CartPage(),
      ),
    ],
  ),
]);
