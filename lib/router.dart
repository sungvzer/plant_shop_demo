import 'package:go_router/go_router.dart';
import 'package:plant_shop_flutter/pages/cart_page.dart';
import 'package:plant_shop_flutter/pages/home_page.dart';
import 'package:plant_shop_flutter/pages/plant_page.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        path: 'cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: 'plants/:plantId',
        builder: (context, state) => PlantPage(
          plantId: int.parse(state.params['plantId']!),
        ),
      ),
    ],
  ),
]);
