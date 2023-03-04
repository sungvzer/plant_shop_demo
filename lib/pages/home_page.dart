import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          actions: const [
            Icon(Icons.shopping_cart_outlined),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Title(),
              const SizedBox(height: 16),
              Row(
                children: const [
                  SearchBar(),
                  SizedBox(width: 16),
                  FilterButton()
                ],
              ),
              const SizedBox(height: 24),
              Categories(categories: [
                Category(label: "Flower", active: true),
                Category(label: "Trees"),
                Category(label: "Indoor"),
                Category(label: "Outdoor"),
                Category(label: "Gardening tools"),
              ]),
              const SizedBox(height: 12),
              const ProductCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Wrap(spacing: 16, children: const [
        PlantCard(),
        PlantCard(),
        PlantCard(),
        PlantCard(),
        PlantCard(),
        PlantCard(),
        PlantCard(),
        PlantCard(),
        PlantCard()
      ]),
    );
  }
}

class PlantCard extends StatelessWidget {
  const PlantCard({super.key});

  static List<String> plantNames = const [
    "Unlawful Sinner",
    "Carnivore Bastard",
    "Sunshine Killer",
    "Greedy Fucker",
    "Spit-in-my-mouth"
  ];

  @override
  Widget build(BuildContext context) {
    final rng = Random();
    final random = rng.nextInt(5);
    randomPrice() => rng.nextInt(50) * 10;
    final theme = Theme.of(context);
    return Material(
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(16),
      color: Colors.green[100]!.withAlpha(40),
      child: Container(
        constraints: const BoxConstraints.tightForFinite(width: 200),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("assets/plants/plant$random.png"),
                height: 200,
                width: 170,
              ),
              const SizedBox(height: 16),
              Text(
                plantNames[random],
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        random > 2 ? "From" : "",
                        style: theme.textTheme.labelMedium
                            ?.copyWith(color: Colors.black54),
                      ),
                      Text(
                        "\$${randomPrice()}",
                        style: theme.textTheme.titleLarge,
                      )
                    ],
                  ),
                  Ink(
                    width: 35,
                    height: 35,
                    padding: const EdgeInsets.all(0),
                    decoration: ShapeDecoration(
                      color: Colors.green[200]!,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.add,
                      ),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    // return SizedBox(
    //   width: 200,
    //   height: 343,
    //   child: Card(
    //     child: ,
    //   ),
    // );
  }
}

class Category {
  final String label;
  bool active;

  Category({required this.label, this.active = false});
}

class Categories extends StatefulWidget {
  final List<Category> categories;

  const Categories({
    required this.categories,
    super.key,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: widget.categories.map((e) {
          if (e.active) {
            return Container(
              key: Key(e.label),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.green[100]?.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Text(
                e.label,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
              ),
            );
          } else {
            return TextButton(
              key: Key(e.label),
              onPressed: () {
                setState(() {
                  for (var element in widget.categories) {
                    element.active = element.label == e.label;
                  }
                });
              },
              child: Text(
                e.label,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green[100]!,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(16),
        iconSize: 28,
        onPressed: () {
          debugPrint("TODO: implement filtering");
        },
        icon: const Icon(Icons.filter_list_alt),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var textEditingController = TextEditingController(text: "");
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green[100]!,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.search, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Search...",
                    ),
                    controller: textEditingController,
                    onSubmitted: (str) {
                      debugPrint("TODO: search for $str");
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: Theme.of(context).textTheme.headlineMedium,
      const TextSpan(
        children: [
          TextSpan(
            text: "Plant",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: " "),
          TextSpan(text: "Shop"),
        ],
      ),
    );
  }
}
