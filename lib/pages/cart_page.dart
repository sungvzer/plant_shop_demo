import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plant_shop_flutter/helpers.dart';
import 'package:plant_shop_flutter/models/plant_cart_item.dart';
import 'package:plant_shop_flutter/providers/cart_provider.dart';

class CartPage extends HookConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          // leading: const Icon(Icons.menu),
          ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CartPageTitle(),
              if (cart.items.isEmpty)
                Expanded(
                  child: Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.remove_shopping_cart),
                        SizedBox(height: 5),
                        Text("Your cart is empty."),
                      ],
                    ),
                  ),
                ),
              if (cart.items.isNotEmpty) ...[
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      height: MediaQuery.of(context).size.height - 320,
                    ),
                    child: ListView(
                      children: [
                        for (final item in cart.items)
                          PlantCartCard(
                            item: item,
                          ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: theme.textTheme.titleLarge,
                        ),
                        const Text("Discount"),
                        Text(
                          "Total",
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${cart.total}",
                          style: theme.textTheme.titleLarge?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2,
                          ),
                        ),
                        const Text("-5%"),
                        Text(
                          "\$${(cart.total * (100 - 5) / 100).toStringAsFixed(2)}",
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class PlantCartCard extends StatelessWidget {
  final PlantCartItem item;

  const PlantCartCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: leafBorder,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(item.imagePath),
              height: 60,
              width: 40,
            ),
            const SizedBox(width: 20),
            Text(
              item.name,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  "\$${item.price}",
                  style: theme.textTheme.bodyLarge,
                ),
                QuantityWidget(item: item),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuantityWidget extends HookConsumerWidget {
  static const double iconSize = 16.0;
  final PlantCartItem item;

  const QuantityWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              ref.read(cartProvider.notifier).removePlant(item);
            },
            child: Ink(child: const Icon(Icons.remove, size: iconSize)),
          ),
          const SizedBox(width: 5),
          Text(
            "${item.quantity}",
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              ref.read(cartProvider.notifier).addPlant(item);
            },
            child: const Icon(Icons.add, size: iconSize),
          ),
        ],
      ),
    );
  }
}

class CartPageTitle extends HookConsumerWidget {
  const CartPageTitle({
    super.key,
  });

  @override
  Widget build(context, ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.watch(cartProvider.notifier);
    return Row(
      children: [
        Text.rich(
          style: Theme.of(context).textTheme.headlineMedium,
          const TextSpan(
            children: [
              TextSpan(text: "Your cart"),
            ],
          ),
        ),
        if (cart.items.isNotEmpty) ...[
          const Spacer(),
          InkWell(
            onTap: () {
              cartNotifier.empty();
            },
            child: Ink(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.delete),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
