import 'package:flutter/material.dart';

import 'package:inventaire_exo_muscu/data/dummy_data.dart';
import 'package:inventaire_exo_muscu/models/category.dart';
import 'package:inventaire_exo_muscu/models/meal.dart';
import 'package:inventaire_exo_muscu/screens/meals.dart';
import 'package:inventaire_exo_muscu/widgets/category_grid_item.dart';
import 'package:inventaire_exo_muscu/widgets/responsive_body.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavotite});

  final void Function(Meal meal) onToggleFavotite;

  void _selectCategory(BuildContext context, Category category) {
    final mealsCat = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: mealsCat,
          onToggleFavotite: onToggleFavotite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBody(
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(
                  context,
                  category,
                );
              },
            )
        ],
      ),
    );
  }
}
