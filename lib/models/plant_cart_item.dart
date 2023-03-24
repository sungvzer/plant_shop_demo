import 'package:flutter/material.dart';
import 'package:plant_shop_flutter/models/plant.dart';

@immutable
class PlantCartItem extends Plant {
  final int quantity;

  const PlantCartItem({
    required super.name,
    required super.description,
    required super.price,
    required super.size,
    required this.quantity,
    required super.imagePath,
    required super.id,
    required super.fertilityPercentage,
    required super.lightPercentage,
    required super.temperatureCelsius,
    required super.waterPercentage,
  });

  static PlantCartItem fromPlant(Plant plant) {
    return PlantCartItem(
      name: plant.name,
      description: plant.description,
      price: plant.price,
      size: plant.size,
      quantity: 1,
      imagePath: plant.imagePath,
      id: plant.id,
      fertilityPercentage: plant.fertilityPercentage,
      lightPercentage: plant.lightPercentage,
      temperatureCelsius: plant.temperatureCelsius,
      waterPercentage: plant.waterPercentage,
    );
  }

  PlantCartItem copyWith({
    String? name,
    String? description,
    int? price,
    PlantSize? size,
    int? quantity,
    String? imagePath,
    int? id,
    int? fertilityPercentage,
    int? lightPercentage,
    int? temperatureCelsius,
    int? waterPercentage,
  }) {
    return PlantCartItem(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath ?? this.imagePath,
      id: id ?? this.id,
      fertilityPercentage: fertilityPercentage ?? this.fertilityPercentage,
      lightPercentage: lightPercentage ?? this.lightPercentage,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      waterPercentage: waterPercentage ?? this.waterPercentage,
    );
  }
}
