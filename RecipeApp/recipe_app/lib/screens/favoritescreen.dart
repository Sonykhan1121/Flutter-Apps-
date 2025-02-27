import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipeProvider.dart';
import '../widgets/recipe_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = Provider.of<RecipeProvider>(context).favoriteRecipes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: favoriteRecipes.isEmpty
          ? Center(
        child: Text(
          'You have no favorite recipes yet!',
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: favoriteRecipes.length,
        itemBuilder: (ctx, i) => RecipeItem(
          id: favoriteRecipes[i].id,
        ),
      ),
    );
  }
}