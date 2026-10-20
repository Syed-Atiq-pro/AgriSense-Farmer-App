class Crop {
  final String id;
  final String name;
  final String variety;
  final DateTime plantedDate;
  final String stage; // Sowing, Growing, Flowering, Harvest
  final String notes;

  Crop({
    required this.id,
    required this.name,
    required this.variety,
    required this.plantedDate,
    required this.stage,
    this.notes = '',
  });
}