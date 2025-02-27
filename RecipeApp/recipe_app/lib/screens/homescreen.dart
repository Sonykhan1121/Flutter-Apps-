import 'package:flutter/material.dart';

import '../widgets/categoryselector.dart';
import '../widgets/recipe_grid.dart';
import 'addrecipe.dart';
import 'favoritescreen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text('Bangladeshi Recipes'),
        actions: [
          IconButton(
            icon:  Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding:  EdgeInsets.all(16),
            child: Text(
              'Discover Authentic Bangladeshi Cuisine',
              textAlign: TextAlign.center,
            ),
          ),
          CategorySelector(
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
            selectedCategory: _selectedCategory,
          ),
          Expanded(
            child: RecipeGrid(category: _selectedCategory),
          ),
        ],
      ),
      // In home_screen.dart
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) =>  AddRecipeScreen(),
            ),
          );
        },
        child:  Icon(Icons.add),
      ),
    );
  }
}