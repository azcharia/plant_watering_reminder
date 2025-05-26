import 'package:flutter/material.dart';
import 'package:plant_watering_reminder/models/plant.dart';
import 'package:plant_watering_reminder/screens/add_plant_screen.dart';
import 'package:plant_watering_reminder/services/plant_service.dart';
import 'package:plant_watering_reminder/widgets/plant_card.dart';
import 'dart:math'; // Import for random number generation

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PlantService _plantService = PlantService();
  List<Plant> _plants = [];

  // List of educational daily tips
  final List<String> _dailyTips = [
    'Tahukah kamu bila menyiram tanaman di pagi hari adalah waktu terbaik karena mengurangi penguapan air?',
    'Tahukah kamu bila genangan air di pot bisa menyebabkan akar tanaman busuk?',
    'Tahukah kamu bila sebagian besar tanaman lebih baik disiram hingga air keluar dari dasar pot?',
    'Tahukah kamu bila kebutuhan air tanaman berbeda-beda tergantung jenis, ukuran, dan lingkungannya?',
    'Tahukah kamu bila daun menguning bisa jadi tanda overwatering atau underwatering?',
    'Tahukah kamu bila tanaman juga butuh kelembaban udara, tidak hanya air di tanah?',
    'Tahukah kamu bila air hujan adalah air terbaik untuk tanaman karena bebas klorin?',
    'Tahukah kamu bila cek kelembaban tanah dengan jari adalah cara terbaik untuk tahu kapan harus menyiram?',
  ];

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    final plants = await _plantService.getPlants();
    setState(() {
      _plants = plants;
    });
  }

  Future<void> _waterPlant(Plant plant) async {
    final updatedPlant = Plant(
      id: plant.id,
      name: plant.name,
      type: plant.type,
      lastWatered: DateTime.now(),
    );
    await _plantService.updatePlant(updatedPlant);
    _loadPlants(); // Reload plants to update the UI

    // Show a daily tip after watering
    _showDailyTip();
  }

  void _showDailyTip() {
    final random = Random();
    final tipIndex = random.nextInt(_dailyTips.length);
    final tip = _dailyTips[tipIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tips Harian!'),
          content: Text(tip),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Oke'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePlant(String plantId) async {
    await _plantService.deletePlant(plantId);
    _loadPlants(); // Reload plants to update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Plants')),
      body:
          _plants.isEmpty
              ? const Center(
                child: Text('No plants added yet. Add your first plant!'),
              )
              : ListView.builder(
                itemCount: _plants.length,
                itemBuilder: (context, index) {
                  final plant = _plants[index];
                  return PlantCard(
                    plant: plant,
                    onWaterPressed: () => _waterPlant(plant),
                    onDeletePressed: () => _deletePlant(plant.id),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlantScreen()),
          );
          _loadPlants(); // Reload plants when returning from AddPlantScreen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
