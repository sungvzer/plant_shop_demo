import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plant_shop_flutter/models/plant.dart';
import 'package:plant_shop_flutter/pages/home_page.dart';

const loremIpsum =
    'Fusce ac gravida felis, non lobortis lacus. In lacinia nibh at risus porttitor, viverra varius eros pulvinar. Nullam eget lectus a lacus pretium posuere et nec purus. Curabitur rutrum ornare elit tincidunt pulvinar. Morbi sit amet elit odio. Suspendisse ultricies efficitur neque eget pellentesque. Aenean nisl nibh, lacinia id ante eu, pulvinar egestas lectus. Fusce eu blandit elit.';

final plantProvider =
    StateNotifierProvider<DummyPlantNotifier, List<Plant>>((ref) {
  return DummyPlantNotifier([
    Plant(
      description: loremIpsum,
      imagePath: getAssetPath(0),
      name: 'Spit-in-my-mouth',
      price: 100,
      size: PlantSize.medium,
      id: 0,
      fertilityPercentage: 30,
      temperatureCelsius: 20,
      lightPercentage: 90,
      waterPercentage: 50,
    ),
    Plant(
      description: loremIpsum,
      imagePath: getAssetPath(1),
      name: 'Carnivore Bastard',
      price: 340,
      size: PlantSize.large,
      id: 1,
      fertilityPercentage: 80,
      temperatureCelsius: 24,
      lightPercentage: 70,
      waterPercentage: 80,
    ),
    Plant(
      description: loremIpsum,
      imagePath: getAssetPath(2),
      name: 'Sunshine Killer',
      price: 130,
      size: PlantSize.extraLarge,
      id: 2,
      fertilityPercentage: 60,
      temperatureCelsius: 18,
      lightPercentage: 80,
      waterPercentage: 40,
    ),
    Plant(
      description: loremIpsum,
      imagePath: getAssetPath(3),
      name: 'Greedy Sunshine Hoarder',
      price: 401,
      size: PlantSize.small,
      id: 3,
      fertilityPercentage: 50,
      temperatureCelsius: 22,
      lightPercentage: 85,
      waterPercentage: 35,
    ),
    Plant(
      description: loremIpsum,
      imagePath: getAssetPath(4),
      name: 'Wife Beater',
      price: 15,
      size: PlantSize.large,
      id: 4,
      fertilityPercentage: 50,
      temperatureCelsius: 22,
      lightPercentage: 85,
      waterPercentage: 35,
    ),
  ]);
});

class DummyPlantNotifier extends StateNotifier<List<Plant>> {
  DummyPlantNotifier(super.state);

  Plant? findById(int plantId) {
    try {
      return state.firstWhere((element) => element.id == plantId);
    } on StateError catch (_) {
      return null;
    }
  }
}
