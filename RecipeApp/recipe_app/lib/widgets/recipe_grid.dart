import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipeProvider.dart';
import 'recipe_item.dart';

class RecipeGrid extends StatelessWidget {
  final String category;

  const RecipeGrid({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final recipeData = Provider.of<RecipeProvider>(context);
    final recipes = category == 'All'
        ? recipeData.recipes
        : recipeData.getRecipesByCategory(category);

    return recipes.isEmpty
        ? Center(
      child: Text(
        'No recipes found!',

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
      itemCount: recipes.length,
      itemBuilder: (ctx, i) => RecipeItem(
        id: recipes[i].id,
      ),
    );
  }
}