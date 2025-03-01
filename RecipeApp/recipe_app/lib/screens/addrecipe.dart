import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/recipeProvider.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  String _selectedCategory = 'Main Course';

  final Map<String, dynamic> _recipeData = {
    'name': '',
    'imageUrl': '',
    'description': '',
    'ingredients': <String>[],
    'instructions': <String>[],
    'cookTime': 0,
    'category': 'Main Course',
  };

  final List<String> _categories = ['Main Course', 'Fish', 'Rice', 'Dessert'];

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    // Process ingredients and instructions from text controllers
    _recipeData['ingredients'] =
        _ingredientsController.text
            .split('\n')
            .where((ingredient) => ingredient.trim().isNotEmpty)
            .toList();

    _recipeData['instructions'] =
        _instructionsController.text
            .split('\n')
            .where((instruction) => instruction.trim().isNotEmpty)
            .toList();

    // Here you would add the recipe to the provider
    // For example:
    Provider.of<RecipeProvider>(context, listen: false).addRecipe(_recipeData);

    Navigator.of(context).pop();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Update the UI with the selected image
      });
    }
  }

  @override
  void dispose() {
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Recipe'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  // Attach the image picking function to the GestureDetector
                  child: CircleAvatar(
                    radius: 100,
                    // Size of the avatar
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    // Display the selected image
                    child:
                        _image == null
                            ? Icon(Icons.camera_alt, size: 50)
                            : null, // Show an icon if no image is selected
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Recipe Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _recipeData['name'] = value;
                  },
                ),

                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _recipeData['description'] = value;
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Category'),
                  value: _selectedCategory,
                  items:
                      _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  },
                  onSaved: (value) {
                    _recipeData['category'] = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Cook Time (minutes)',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter cook time';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Please enter a number greater than zero';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _recipeData['cookTime'] = int.parse(value!);
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Ingredients (one per line)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(
                    hintText: '1 kg beef, cubed\n2 tbsp ginger paste\n...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 8,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter at least one ingredient';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Instructions (one step per line)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _instructionsController,
                  decoration: const InputDecoration(
                    hintText: 'Heat oil in a pan\nAdd sliced onions\n...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 8,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter at least one instruction';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveForm,
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      'Add Recipe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height:20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
