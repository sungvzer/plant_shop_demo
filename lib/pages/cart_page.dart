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
    final discountTextStyle = theme.textTheme.titleMedium?.copyWith(
      color: theme.colorScheme.primary.withOpacity(0.7),
    );
    var priceTextStyle = theme.textTheme.titleLarge;
    return Scaffold(
      appBar: AppBar(
          // leading: const Icon(Icons.menu),
          ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: [
              const CartPageTitle(),
              Flexible(
                child: (cart.items.isEmpty)
                    ? Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.remove_shopping_cart,
                              size: 48,
                            ),
                            SizedBox(height: 5),
                            Text("Your cart is empty."),
                          ],
                        ),
                      )
                    : ListView(
                        children: [
                          for (final item in cart.items) ...[
                            PlantCartCard(
                              item: item,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ]
                        ],
                      ),
              ),
              if (cart.items.isNotEmpty)
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: priceTextStyle,
                        ),
                        Text(
                          "Discount",
                          style: discountTextStyle,
                        ),
                        Text(
                          "Total",
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${cart.total}",
                          style: theme.textTheme.titleLarge?.copyWith(),
                        ),
                        Text("-5%", style: discountTextStyle),
                        Text(
                          "\$${(cart.total * (100 - 5) / 100).toStringAsFixed(2)}",
                          style: priceTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(item.imagePath),
              height: 70,
              width: 50,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${item.price}',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
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
  static const double iconSize = 32.0;
  final PlantCartItem item;

  const QuantityWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              ref.read(cartProvider.notifier).addPlant(item);
            },
            child: const Icon(Icons.arrow_drop_up, size: iconSize),
          ),
          const SizedBox(width: 5),
          SizedBox(
            child: Text(
              "${item.quantity}",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              ref.read(cartProvider.notifier).removePlant(item);
            },
            child:
                Ink(child: const Icon(Icons.arrow_drop_down, size: iconSize)),
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
