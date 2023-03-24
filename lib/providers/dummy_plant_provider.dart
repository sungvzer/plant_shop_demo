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
    ),
    Plant(
      description: loremIpsum,
      imagePath: getAssetPath(1),
      name: 'Carnivore Bastard',
      price: 340,
      size: PlantSize.large,
      id: 1,
    ),
    Plant(
      description: loremIpsum,
      imagePath: getAssetPath(2),
      name: 'Sunshine Killer',
      price: 130,
      size: PlantSize.extraLarge,
      id: 2,
    ),
    Plant(
      description: loremIpsum,
      imagePath: getAssetPath(3),
      name: 'Greedy Sunshine Hoarder',
      price: 401,
      size: PlantSize.small,
      id: 3,
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
