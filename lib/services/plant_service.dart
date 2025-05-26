import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plant_watering_reminder/models/plant.dart';

class PlantService {
  static const String _plantsKey = 'plants';

  Future<List<Plant>> getPlants() async {
    final prefs = await SharedPreferences.getInstance();
    final String? plantsJson = prefs.getString(_plantsKey);

    if (plantsJson == null) {
      return [];
    }

    final List<dynamic> plantMaps = json.decode(plantsJson);
    return plantMaps.map((map) => Plant.fromMap(map)).toList();
  }

  Future<void> savePlants(List<Plant> plants) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> plantMaps = plants.map((plant) => plant.toMap()).toList();
    final String plantsJson = json.encode(plantMaps);
    await prefs.setString(_plantsKey, plantsJson);
  }

  Future<void> addPlant(Plant plant) async {
    List<Plant> plants = await getPlants();
    plants.add(plant);
    await savePlants(plants);
  }

  Future<void> updatePlant(Plant updatedPlant) async {
    List<Plant> plants = await getPlants();
    int index = plants.indexWhere((plant) => plant.id == updatedPlant.id);
    if (index != -1) {
      plants[index] = updatedPlant;
      await savePlants(plants);
    }
  }

  Future<void> deletePlant(String plantId) async {
    List<Plant> plants = await getPlants();
    plants.removeWhere((plant) => plant.id == plantId);
    await savePlants(plants);
  }
}