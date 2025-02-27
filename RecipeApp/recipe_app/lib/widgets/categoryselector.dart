import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CategorySelector extends StatelessWidget {
  final Function(String) onCategorySelected;
  final String selectedCategory;

  const CategorySelector({
    Key? key,
    required this.onCategorySelected,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      'Main Course',
      'Fish',
      'Rice',
      'Dessert',
    ];

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => onCategorySelected(categories[i]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: selectedCategory == categories[i]
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              categories[i],
              style: TextStyle(
                color: selectedCategory == categories[i]
                    ? Colors.white
                    : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
