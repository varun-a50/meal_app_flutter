import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/category.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/widgets/catergory_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredList = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealScreen(
                  title: category.title,
                  meals: filteredList,
                  onToggleFavorite: onToggleFavorite,
                )));
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          //Alternative to availableCategories.map((catergory) => CategoryGridItem(category: category) ).toList();
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
