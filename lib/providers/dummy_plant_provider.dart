import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plant_shop_flutter/models/plant.dart';
import 'package:plant_shop_flutter/pages/home_page.dart';

final dummyPlantProvider = Provider<List<Plant>>((ref) {
  return [
    Plant(
      description: 'A really cool plant!',
      imagePath: getAssetPath(0),
      name: 'Spit-in-my-mouth',
      price: 100,
      size: PlantSize.medium,
      id: 0,
    ),
    Plant(
      description: 'A really cool plant!',
      imagePath: getAssetPath(1),
      name: 'Carnivore Bastard',
      price: 340,
      size: PlantSize.large,
      id: 1,
    ),
    Plant(
      description: 'A plant.',
      imagePath: getAssetPath(2),
      name: 'Sunshine Killer',
      price: 130,
      size: PlantSize.extraLarge,
      id: 2,
    ),
    Plant(
      description: 'A plant.',
      imagePath: getAssetPath(3),
      name: 'Greedy Sunshine Hoarder',
      price: 401,
      size: PlantSize.small,
      id: 3,
    ),
  ];
});
