class Recipe{
  final String id;
  final String name;
  final String assetUrl;
  final String imageUrl;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final int cookTime;
  final String category;
  final bool isFavorite;

  Recipe({required this.id, required this.name, required this.imageUrl, required this.description, required this.ingredients,
      required this.instructions, required this.cookTime, required this.category,  this.isFavorite = false,required this.assetUrl});


  Recipe copyWith({bool? isFavorite})
  {
    return Recipe(id: id, name: name, imageUrl: imageUrl, description: description, ingredients: ingredients,
      instructions: instructions, cookTime: cookTime, category: category, isFavorite: isFavorite?? this.isFavorite,assetUrl: assetUrl);
  }


}