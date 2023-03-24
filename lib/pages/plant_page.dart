import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plant_shop_flutter/models/plant.dart';
import 'package:plant_shop_flutter/providers/cart_provider.dart';
import 'package:plant_shop_flutter/providers/dummy_plant_provider.dart';

class PlantPage extends StatefulHookConsumerWidget {
  final int plantId;

  const PlantPage({super.key, required this.plantId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlantPageState();
}

class _PlantPageState extends ConsumerState<PlantPage> {
  var iconIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notifier = ref.read(plantProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);
    var plant = notifier.findById(widget.plantId);
    assert(plant != null);
    plant = plant!;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: "Add to cart",
        elevation: 0,
        label: const Text("Add to cart"),
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: child.key == const ValueKey('icon1')
                ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                : Tween<double>(begin: 0.75, end: 1).animate(anim),
            child: ScaleTransition(scale: anim, child: child),
          ),
          child: iconIndex == 0
              ? const Icon(Icons.add, key: ValueKey('icon1'))
              : const Icon(
                  Icons.done,
                  key: ValueKey('icon2'),
                ),
        ),
        onPressed: () async {
          cartNotifier.addPlant(plant!);
          setState(() {
            iconIndex = 1;
          });

          return Future.delayed(
            const Duration(seconds: 1),
            () {
              if (!mounted) return;
              setState(() {
                iconIndex = 0;
              });
            },
          );
        },
      ),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  plant.name,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: theme.textTheme.headlineLarge
                      ?.copyWith(color: theme.colorScheme.onBackground),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),
              PlantImageCarousel(
                plant: plant,
                itemCount: Random().nextInt(5) +
                    1, // TODO: Compute the actual item count
              ),
              const SizedBox(height: 20),
              Text(
                "\$${plant.price}",
                textAlign: TextAlign.left,
                style: theme.textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              Text(
                "Description",
                style: theme.textTheme.headlineMedium,
              ),
              Text(plant.description),
            ],
          ),
        ),
      ),
    );
  }
}

class PlantImageCarousel extends StatefulWidget {
  const PlantImageCarousel({
    super.key,
    required this.plant,
    required this.itemCount,
  });

  final int itemCount;
  final Plant plant;

  @override
  State<PlantImageCarousel> createState() => _PlantImageCarouselState();
}

class _PlantImageCarouselState extends State<PlantImageCarousel> {
  final controller = PageController();
  var currentIndex = 0;

  List<Widget> _getIndicatorWidget(
      BuildContext context, int index, int itemCount) {
    if (itemCount <= 1) {
      return [];
    }
    final theme = Theme.of(context);
    return [
      Container(
        decoration: BoxDecoration(
          color: currentIndex != index
              ? theme.colorScheme.onBackground.withOpacity(0.5)
              : theme.colorScheme.onBackground.withOpacity(1),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: 7,
        height: 7,
      ),
      const SizedBox(
        width: 4,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: widget.itemCount,
            pageSnapping: true,
            controller: controller,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Image(
                    image: AssetImage(widget.plant.imagePath),
                    height: 300,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.itemCount; i++)
              ..._getIndicatorWidget(context, i, widget.itemCount)
          ],
        )
      ],
    );
  }
}
