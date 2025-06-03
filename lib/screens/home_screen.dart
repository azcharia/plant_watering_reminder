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
    'Watering your plants in the morning is highly recommended to minimize evaporation and allow leaves to dry before nightfall.',
    'Avoid leaving your pots in standing water; this can quickly lead to root rot and other fungal issues.',
    'Ensure water drains from the bottom of the pot when watering, indicating thorough saturation and preventing salt buildup.',
    'Plant watering needs are highly individual; always consider the specific plant type, its size, and the environmental conditions.',
    'Yellowing leaves can indicate various issues, including both overwatering and underwatering, requiring careful observation.',
    'Remember that plants also need air humidity, not just water in the soil, especially tropical varieties.',
    'Rainwater is often considered the best water for plants because it\'s naturally soft and free of chlorine and other chemicals.',
    'The "finger test" is a reliable method: insert your finger an inch or two into the soil to check its moisture level before watering.',
    'Provide consistent light conditions for most plants, but be aware that too much direct, harsh sun can scorch sensitive leaves.',
    'Regularly rotate your plants to encourage even growth and prevent them from leaning excessively towards the light source.',
    'Be cautious with fertilizer; over-fertilizing is often more damaging than under-fertilizing and can cause root burn.',
    'Frequent inspection of your plant\'s leaves and stems can help you catch pest infestations early, before they become severe.',
    'Pruning dead or yellowing leaves not only improves your plant\'s appearance but also directs its energy towards healthier new growth.',
    'Signs a plant needs repotting include roots growing out of drainage holes, stunted growth, or the plant drying out too quickly.',
    'Regularly wipe dust off plant leaves; clean leaves absorb light more efficiently and "breathe" better.',
    'Always choose pots with drainage holes; pots without them greatly increase the risk of waterlogging and root rot.',
    'Avoid sudden temperature fluctuations; they can stress plants and make them more susceptible to pests and diseases.',
    'Good air circulation around your plants is crucial for preventing fungal diseases like powdery mildew.',
    'New plants often need time to "acclimate" to their new environment; be patient and observe them closely.',
    'Allow the top inch or two of soil to dry out between waterings for many common houseplants; this prevents root rot.',
    'Don\'t add a layer of pebbles at the bottom of a pot for drainage; it actually raises the water table and can hinder proper drainage.',
    'A sudden drop of leaves can be a sign of environmental shock, often triggered by moving a plant to a new location or changes in temperature.',
    'Remember that succulents and cacti prefer much less frequent watering compared to tropical plants; allow their soil to dry out completely.',
    'Sensitive plants may benefit from distilled or filtered water to avoid tap water chemicals like chlorine and fluoride.',
    'Always clean your gardening tools after each use to prevent the spread of diseases between plants.',
    'While misting provides temporary humidity, a pebble tray filled with water placed under the pot offers a more consistent humidity boost.',
    'Brown, crispy leaf tips often signal low humidity or consistent underwatering; consider increasing ambient moisture.',
    'During winter dormancy, most plants require significantly less water and fertilizer; adjust your routine accordingly.',
    'Selecting the correct pot size is important: too large can lead to overwatering, and too small can stunt growth by restricting roots.',
    'To maintain healthy soil, consider top-dressing your pots with fresh potting mix annually, especially for established plants.'
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
      lastWatered: DateTime.now(), // This is where it's updated
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
          title: const Text('Daily Tips!'),
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
