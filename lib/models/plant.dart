import 'package:flutter/material.dart';

enum PlantSize { small, medium, large, extraLarge }

@immutable
class Plant {
  final String name;
  final String description;
  final int price;
  final PlantSize size;
  final String imagePath;

  final int waterPercentage;
  final int lightPercentage;
  final int temperatureCelsius;
  final int fertilityPercentage;

  final int id;

  const Plant({
    required this.name,
    required this.description,
    required this.price,
    required this.size,
    required this.imagePath,
    required this.id,
    required this.waterPercentage,
    required this.fertilityPercentage,
    required this.lightPercentage,
    required this.temperatureCelsius,
  });
}
