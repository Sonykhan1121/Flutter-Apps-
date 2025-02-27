import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      name: 'Beef Kala Bhuna',
      imageUrl: 'https://i.imgur.com/iJJmfEe.jpg',
      description: 'A traditional Chittagonian beef dish where meat is slow-cooked until tender with aromatic spices.',
      ingredients: [
        '1 kg beef, cubed',
        '3 large onions, finely sliced',
        '2 tbsp ginger paste',
        '2 tbsp garlic paste',
        '2 tsp cumin powder',
        '2 tsp coriander powder',
        '1 tsp red chili powder',
        '1/2 tsp turmeric powder',
        '4-5 green chilies',
        '1/2 cup mustard oil',
        'Salt to taste',
      ],
      instructions: [
        'Heat oil in a deep bottomed pan. Add sliced onions and fry until deep brown.',
        'Add ginger and garlic paste, cook until fragrant.',
        'Add beef cubes and stir well to coat with the mixture.',
        'Add all powdered spices and salt, mix thoroughly.',
        'Cover and cook on low heat for 30 minutes.',
        'Remove cover, add green chilies and cook for another 30-40 minutes until meat is tender and the gravy thickens.',
        'Serve hot with pulao or paratha.',
      ],
      cookTime: 90,
      category: 'Main Course',
      assetUrl: "assets/images/beef_kala_bhuna.jpeg",
    ),
    Recipe(
      id: '2',
      name: 'Ilish Bhapa',
      imageUrl: 'https://i.imgur.com/NTwQhbz.jpg',
      description: 'Steamed hilsa fish with mustard sauce, a Bengali delicacy.',
      ingredients: [
        '4 pieces hilsa fish',
        '4 tbsp mustard paste',
        '2 tbsp poppy seed paste',
        '4-5 green chilies',
        '1/2 tsp turmeric powder',
        '1/4 cup mustard oil',
        'Salt to taste',
      ],
      instructions: [
        'Marinate fish pieces with salt and turmeric powder for 15 minutes.',
        'Mix mustard paste, poppy seed paste, green chilies, turmeric powder, salt, and 2 tbsp mustard oil.',
        'Place fish in a container, pour the mixture over it.',
        'Drizzle remaining mustard oil on top.',
        'Cover and steam for 15-20 minutes.',
        'Serve hot with steamed rice.',
      ],
      cookTime: 35,
      category: 'Fish',
      assetUrl: "assets/images/ilish1.jpg",
    ),
    Recipe(
      id: '3',
      name: 'Pitha (Rice Cake)',
      imageUrl: 'https://i.imgur.com/5YrHaLc.jpg',
      description: 'Traditional Bangladeshi rice cakes, usually prepared during winter.',
      ingredients: [
        '2 cups rice flour',
        '1 cup grated coconut',
        '1 cup jaggery/date molasses',
        '1/2 tsp cardamom powder',
        'Water as needed',
      ],
      instructions: [
        'Mix rice flour with enough water to make a smooth batter.',
        'In a separate bowl, mix coconut, jaggery, and cardamom powder.',
        'Heat a non-stick pan, pour a ladle of batter to make a thin pancake.',
        'Place a spoonful of filling in the center, fold the pancake, and cook until golden.',
        'Serve warm.',
      ],
      cookTime: 30,
      category: 'Dessert',
      assetUrl: "assets/images/rice_cake.jpg",
    ),
    Recipe(
      id: '4',
      name: 'Chicken Rezala',
      imageUrl: 'https://i.imgur.com/Y5OQHGL.jpg',
      description: 'A rich, creamy Mughlai-inspired chicken dish popular in Bangladesh.',
      ingredients: [
        '1 kg chicken pieces',
        '1 cup yogurt',
        '1/4 cup cashew paste',
        '2 tbsp ginger paste',
        '2 tbsp garlic paste',
        '1 tsp white pepper powder',
        '2-3 green chilies, slit',
        '1 tsp garam masala powder',
        '4 tbsp ghee',
        'Salt to taste',
      ],
      instructions: [
        'Marinate chicken with yogurt, ginger-garlic paste, and salt for 2 hours.',
        'Heat ghee in a pan, add marinated chicken and cook on medium heat.',
        'Add cashew paste, white pepper powder, and stir well.',
        'Add 1/2 cup water, cover, and simmer until chicken is tender.',
        'Add green chilies and garam masala, cook for another 5 minutes.',
        'Serve hot with naan or paratha.',
      ],
      cookTime: 45,
      category: 'Main Course',
      assetUrl: "assets/images/chicken_rajala1.jpg",
    ),
    Recipe(
      id: '5',
      name: 'Dhakai Kachchi Biryani',
      imageUrl: 'https://i.imgur.com/8F1tRsq.jpg',
      description: 'Famous biryani from Dhaka, cooked with tender meat and aromatic spices.',
      ingredients: [
        '1 kg mutton, cubed',
        '3 cups basmati rice, soaked',
        '2 cups yogurt',
        '4 large onions, thinly sliced and fried',
        '2 tbsp ginger paste',
        '2 tbsp garlic paste',
        '2 tsp cumin powder',
        '2 tsp coriander powder',
        '1 tsp red chili powder',
        '1 tsp garam masala',
        '1/4 cup mint leaves',
        '1/4 cup coriander leaves',
        '5-6 green chilies',
        '1/2 cup ghee',
        'Salt to taste',
      ],
      instructions: [
        'Marinate mutton with yogurt, ginger-garlic paste, and spices for 4 hours.',
        'Parboil rice with whole spices until 70% cooked, drain.',
        'In a heavy-bottomed pot, layer half the rice, then the marinated meat, then the remaining rice.',
        'Sprinkle fried onions, mint, coriander leaves, and ghee on top.',
        'Seal the pot with dough, cook on low heat for 45 minutes.',
        'Let it rest for 10 minutes before opening.',
        'Serve hot with raita.',
      ],
      cookTime: 90,
      category: 'Rice',
      assetUrl: "assets/images/kacchi_biriyani2.jpg",
    ),
  ];

  List<Recipe> get recipes => [..._recipes];

  List<Recipe> get favoriteRecipes => _recipes.where((recipe) => recipe.isFavorite).toList();

  Recipe findById(String id) {
    return _recipes.firstWhere((recipe) => recipe.id == id);
  }

  void toggleFavorite(String id) {
    final int index = _recipes.indexWhere((recipe) => recipe.id == id);
    if (index >= 0) {
      _recipes[index] = _recipes[index].copyWith(isFavorite: !_recipes[index].isFavorite);
      notifyListeners();
    }
  }

  List<Recipe> getRecipesByCategory(String category) {
    return _recipes.where((recipe) => recipe.category == category).toList();
  }
  void addRecipe(Map<String, dynamic> recipeData) {
    final newRecipe = Recipe(
      id: DateTime.now().toString(),
      name: recipeData['name'],
      imageUrl: recipeData['imageUrl'],
      description: recipeData['description'],
      ingredients: recipeData['ingredients'],
      instructions: recipeData['instructions'],
      cookTime: recipeData['cookTime'],
      category: recipeData['category'],
      assetUrl: recipeData['assetUrl'],

    );

    _recipes.add(newRecipe);
    notifyListeners();
  }
}