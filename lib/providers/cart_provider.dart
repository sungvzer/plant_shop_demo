import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plant_shop_flutter/models/plant.dart';
import 'package:plant_shop_flutter/models/plant_cart_item.dart';

@immutable
class CartState {
  final List<PlantCartItem> items;
  final int total;

  const CartState({required this.items, this.total = 0});
}

// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState(items: []));

  void addPlant(Plant plant) {
    List<PlantCartItem> newPlantItems = [];
    bool added = false;
    for (final plantItem in state.items) {
      late PlantCartItem newPlantItem;
      if (plantItem.name == plant.name) {
        newPlantItem = plantItem.copyWith(quantity: plantItem.quantity + 1);
        added = true;
      } else {
        newPlantItem = plantItem;
      }

      newPlantItems.add(newPlantItem);
    }

    if (!added) {
      newPlantItems.add(PlantCartItem.fromPlant(plant));
    }

    state = CartState(items: newPlantItems, total: state.total + plant.price);
  }

  void removePlant(Plant plant) {
    List<PlantCartItem> newPlantItems = [];
    int newTotal = state.total;

    for (final statePlant in state.items) {
      if (statePlant.name != plant.name) {
        newPlantItems.add(statePlant);
        continue;
      }
      if (statePlant.quantity > 1) {
        newPlantItems
            .add(statePlant.copyWith(quantity: statePlant.quantity - 1));
      }
      newTotal -= plant.price;
    }
    state = CartState(items: newPlantItems, total: newTotal);
  }

  void empty() {
    state = const CartState(items: []);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
