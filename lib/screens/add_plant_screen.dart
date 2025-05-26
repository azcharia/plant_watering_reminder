import 'package:flutter/material.dart';
import 'package:plant_watering_reminder/models/plant.dart';
import 'package:plant_watering_reminder/services/plant_service.dart';
import 'package:uuid/uuid.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _autocompletePlantNameController;
  String? _selectedPlantType;
  final PlantService _plantService = PlantService();
  final Uuid _uuid = const Uuid();

  // Example plant types - you can expand this
  final List<String> _plantTypes = [
    'Succulent',
    'Fern',
    'Flowering Plant',
    'Herb',
    'Vegetable',
  ];

  // List of plant name suggestions with categories
final List<String> _plantSuggestions = [
  // Succulents (50+)
  'Aeonium Arboreum',
  'Agave',
  'Aichryson',
  'Aloe Vera',
  'Anacampseros',
  'ArgYRODUNUM',
  'Aeonium Black Rose',
  'Aeonium Kiwi',
  'Aeonium Haworthii',
  'Aeonium Nobile',
  'Aeonium Zwartkop',
  'Aeonium Tabuliforme',
  'Aeonium Sunburst',
  'Anacampseros Telephiastrum',
  'Burro\'s Tail',
  'Cactus',
  'Cactus Flower',
  'Crassula',
  'Dudleya',
  'Echevaria',
  'Echeveria \'Perle Von Nürnberg\'',
  'Echeveria \'Blue Rose\'',
  'Echeveria \'Raindrops\'',
  'Echeveria \'Lilacina\'',
  'Echeveria \'Rouge Curls\'',
  'Elephant Bush',
  'Graptosedum \'Francesco Baldi\'',
  'Graptosedum \'Sunset\'',
  'Graptopetalum Paraguayense',
  'Haworthia',
  'Jade Plant',
  'Kalanchoe',
  'Kalanchoe Beharensis',
  'Kalanchoe Tomentosa',
  'Kalanchoe Pinnata',
  'Kalanchoe Fedtschenkoi',
  'Kalanchoe Marmorata',
  'Lithops',
  'Pachyphytum',
  'Pachyveria',
  'Peperomia',
  'Portulacaria Afra',
  'Sedum',
  'Sedum Morganianum',
  'Sedum Rubrotinctum',
  'Sempervivum',
  'Senecio',
  'Senecio Rowleyanus',
  'Senecio Articulatus',
  'String of Pearls',
  'String of Bananas',
  'String of Buttons',
  'String of Dolphins',
  'String of Hearts',
  'Tylecodon',
  'Venus Hair',
  'Yucca',

  // Ferns (50+)
  'Asparagus Fern',
  'Autumn Fern',
  'Bird\'s Nest Fern',
  'Blue Star Fern',
  'Boston Fern',
  'Bubbling Brook Fern',
  'Cape Fern',
  'Christmas Fern',
  'Crape Fern',
  'Deer Fern',
  'Dog Fern',
  'Elegant Fern',
  'Elkhorn Fern',
  'Fernwood Fern',
  'Filmy Fern',
  'Flowering Fern',
  'Golden Sweet Fern',
  'Grass Fern',
  'Holly Fern',
  'Japanese Holly Fern',
  'Japanese Painted Fern',
  'King Fern',
  'Lady Fern',
  'Leatherleaf Fern',
  'Leopard Fern',
  'Licorice Fern',
  'Maidenhair Fern',
  'Mango Fern',
  'Margaret\'s Pride',
  'Mediterranean Sword Fern',
  'Metallic Blonde',
  'Microsorium Scolopendria',
  'Mother Fern',
  'Ostrich Fern',
  'Polystichum',
  'Prayer Plant',
  'Rubber Plant',
  'Shield Fern',
  'Silver Fern',
  'Southern Hilo Fern',
  'Tree Fern',
  'Tropical Fern',
  'Walking Fern',
  'Western Sword Fern',
  'Wood Fern',
  'Woodwardia',
  'Wrinkled Holly Fern',
  'Xanadu Iron Plant',
  'Zamia Fern',
  
  // Flowering Plants (50+)
  'African Violet',
  'Amaryllis',
  'Azalea',
  'Baby\'s Breath',
  'Begonia',
  'Bird of Paradise',
  'Bougainvillea',
  'Bromelia',
  'Cactus Flower',
  'Caladium',
  'Camellia',
  'Canna',
  'Carnation',
  'Christmas Cactus',
  'Clivia',
  'Clematis',
  'Coleus',
  'Cosmos',
  'Daffodil',
  'Dahila',
  'Daisy',
  'Dandelion',
  'Daylily',
  'Delphinium',
  'Dendrobium',
  'Easter Lily',
  'Edelweiss',
  'Freesia',
  'Fuchsia',
  'Gardenia',
  'Gaura',
  'Gladiolus',
  'Globe Thistle',
  'Hibiscus',
  'Hyacinth',
  'Hydrangea',
  'Impatiens',
  'Iris',
  'Jasmine',
  'Kalanchoe',
  'Kangaroo Paw',
  'Lavender',
  'Lily of the Valley',
  'Lupine',
  'Marigold',
  'Milkweed',
  'Narcissus',
  'Nasturtium',
  'Orchid',
  'Osteospermum',
  'Pansy',
  'Peony',
  'Petunia',
  'Phlox',
  'Primrose',
  'Protea',
  'Rose',
  'Snapdragon',
  'Sunflower',
  'Sweet Pea',
  'Tulip',
  'Verbena',
  'Violet',
  'Wisteria',
  'Zinnia',
  
  // Herbs (50+)
  'Anise',
  'Basil',
  'Borage',
  'Catnip',
  'Celery Leaf',
  'Chervil',
  'Chives',
  'Cilantro',
  'Clary Sage',
  'Comfrey',
  'Coriander',
  'Costmary',
  'Dill',
  'Echinacea',
  'Endive',
  'Fennel',
  'Garlic',
  'Germander',
  'Ginger',
  'Ground Ivy',
  'Hyssop',
  'Lavender',
  'Lemon Balm',
  'Lemon Grass',
  'Lemon Mint',
  'Lemon Peel',
  'Lemon Verbena',
  'Lemon Thyme',
  'Lemon Balm',
  'Lemon Myrtle',
  'Lemongrass',
  'Lemon Thyme',
  'Lemon Verbena',
  'Lemongrass',
  'Lemon Myrtle',
  'Lemon Balm',
  'Lemon Peel',
  'Mint',
  'Motherwort',
  'Nasturtium',
  'Oregano',
  'Parsley',
  'Peppermint',
  'Rosemary',
  'Sage',
  'Savory',
  'Sorrel',
  'Spearmint',
  'Stevia',
  'Tarragon',
  'Thyme',
  'Woodruff',
  'Yarrow',
  'Za\'atar',
  'Zedoary',
  
  // Vegetables (50+)
  'Artichoke',
  'Asparagus',
  'Bamboo Shoot',
  'Bean',
  'Beet',
  'Bell Pepper',
  'Broccoli',
  'Brussels Sprouts',
  'Cabbage',
  'Carrot',
  'Cauliflower',
  'Celery',
  'Chayote',
  'Chili Pepper',
  'Corn',
  'Cucumber',
  'Eggplant',
  'Endive',
  'Garlic',
  'Green Beans',
  'Greens',
  'Gourd',
  'Horseradish',
  'Kale',
  'Kohlrabi',
  'Leeks',
  'Lettuce',
  'Lima Beans',
  'Okra',
  'Onion',
  'Parsnips',
  'Pea',
  'Peppers',
  'Potato',
  'Pumpkin',
  'Radish',
  'Rhubarb',
  'Rutabaga',
  'Salsify',
  'Scallion',
  'Spinach',
  'Squash',
  'String Beans',
  'Tomato',
  'Turnip',
  'Watercress',
  'Wild Garlic',
  'Winter Squash',
  'Yam',
  'Zucchini',
];

  @override
  void initState() {
    super.initState();
    _autocompletePlantNameController = TextEditingController();
  }

  @override
  void dispose() {
    _autocompletePlantNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Plant')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _plantSuggestions.where((String option) {
                    return option.toLowerCase().startsWith(
                      textEditingValue.text.toLowerCase(),
                    );
                  });
                },
                fieldViewBuilder: (
                  BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted,
                ) {
                  _autocompletePlantNameController =
                      textEditingController; // Assign the controller provided by Autocomplete
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Plant Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a plant name';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                    },
                  );
                },
                onSelected: (String selection) {
                  // The textEditingController already has the selected value.
                  print('You selected: $selection');
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Plant Type',
                  border: OutlineInputBorder(),
                ),
                value: _selectedPlantType,
                items:
                    _plantTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPlantType = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a plant type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newPlant = Plant(
                      id: _uuid.v4(),
                      name: _autocompletePlantNameController.text,
                      type: _selectedPlantType!,
                      lastWatered: DateTime.now(), // Set initial watered time
                    );
                    await _plantService.addPlant(newPlant);
                    Navigator.pop(context); // Go back to the home screen
                  }
                },
                child: const Text('Add Plant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
