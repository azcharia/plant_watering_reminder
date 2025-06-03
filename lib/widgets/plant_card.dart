import 'package:flutter/material.dart';
import 'package:plant_watering_reminder/models/plant.dart';
import 'package:intl/intl.dart'; // Import the intl package

class PlantCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onWaterPressed;
  final VoidCallback onDeletePressed;

  const PlantCard({
    Key? key,
    required this.plant,
    required this.onWaterPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plant.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Type: ${plant.type}'),
            Text(
              'Last Watered: ${DateFormat('dd-MM-yyyy HH:mm').format(plant.lastWatered.toLocal())}',
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onWaterPressed,
                  icon: const Icon(Icons.water_drop),
                  label: const Text('Watered!'),
                ),
                TextButton.icon(
                  onPressed: onDeletePressed,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}