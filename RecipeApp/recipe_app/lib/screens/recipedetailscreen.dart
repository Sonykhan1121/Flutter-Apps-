import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipeProvider.dart';


class RecipeDetailScreen extends StatelessWidget {
  final String id;

  const RecipeDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<RecipeProvider>(context, listen: false).findById(id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black38,
                ),
              ),
              background: Hero(
                tag: recipe.id,
                child: Image.asset(
                  recipe.assetUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            actions: [
              Consumer<RecipeProvider>(
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
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(recipe.category),
                          backgroundColor: Colors.green.shade100,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timer, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text('${recipe.cookTime} mins'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Description',

                    ),
                    const SizedBox(height: 10),
                    Text(
                      recipe.description,

                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ingredients',

                    ),
                     SizedBox(height: 10),
                    ...recipe.ingredients.map((ingredient) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('• '),
                          Expanded(
                            child: Text(
                              ingredient,

                            ),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(height: 20),
                    Text(
                      'Instructions',

                    ),
                     SizedBox(height: 10),
                    ...recipe.instructions.asMap().entries.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.green,
                            child: Text(
                              '${entry.key + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                           SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              entry.value,
                            ),
                          ),
                        ],
                      ),
                    )),
                     SizedBox(height: 50),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}