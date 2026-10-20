import 'package:flutter/material.dart';
import '../models/crop.dart';

class CropProvider with ChangeNotifier {
  final List<Crop> _crops = [
    Crop(
      id: '1',
      name: 'Wheat',
      variety: 'HD-2967',
      plantedDate: DateTime.now().subtract(const Duration(days: 45)),
      stage: 'Growing',
      notes: 'Looking healthy',
    ),
    Crop(
      id: '2',
      name: 'Rice',
      variety: 'Basmati',
      plantedDate: DateTime.now().subtract(const Duration(days: 20)),
      stage: 'Sowing',
    ),
  ];

  List<Crop> get crops => _crops;

  void addCrop(Crop crop) {
    _crops.add(crop);
    notifyListeners();
  }

  void removeCrop(String id) {
    _crops.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}