class Plant {
  String id;
  String name;
  String type;
  DateTime lastWatered;
  // Add more properties as needed, e.g., watering frequency, image path, etc.

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.lastWatered,
  });

  // Convert a Plant object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'lastWatered': lastWatered.toIso8601String(),
    };
  }

  // Extract a Plant object from a Map object
  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      lastWatered: DateTime.parse(map['lastWatered']),
    );
  }
}