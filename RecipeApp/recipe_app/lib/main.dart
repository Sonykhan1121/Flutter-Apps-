import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/providers/recipeProvider.dart';
import 'package:recipe_app/screens/homescreen.dart';
import 'package:recipe_app/theme/app_theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: MaterialApp(
        theme: AppTheme.getTheme(context),
        title: 'Bangladeshi Recipes',
        debugShowCheckedModeBanner: false,
        home:  HomeScreen(),
      ),
    );
  }
}