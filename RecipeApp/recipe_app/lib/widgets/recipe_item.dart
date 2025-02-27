import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipeProvider.dart';
import '../screens/recipedetailscreen.dart';


class RecipeItem extends StatelessWidget {
  final String id;

  const RecipeItem({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeProvider>(context, listen: false).findById(id);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            recipe.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Consumer<RecipeProvider>(
            builder: (ctx, recipes, _) => IconButton(
              icon: Icon(
                recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                recipes.toggleFavorite(recipe.id);
              },
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => RecipeDetailScreen(id: id),
              ),
            );
          },
          child: Hero(
            tag: recipe.id,
            child: FadeInImage(
              placeholder:  AssetImage(recipe.assetUrl),
              image: AssetImage(recipe.assetUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}