import 'package:flutter/material.dart';
import 'package:inventaire_exo_muscu/models/meal.dart';
import 'package:inventaire_exo_muscu/screens/meals_description.dart';
import 'package:inventaire_exo_muscu/widgets/appbar.dart';
import 'package:inventaire_exo_muscu/widgets/meals_item.dart';
import 'package:inventaire_exo_muscu/widgets/responsive_body.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavotite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavotite;

  void onSelectMeal(BuildContext context, Meal meals) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsDescriptionScreen(
              meal: meals,
              onToggleFavotite: onToggleFavotite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealsItems(
            meal: meals[index],
            onSelectMeal: (meal) {
              onSelectMeal(context, meal);
            },
          );
        });
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("TEQSS",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            const SizedBox(),
            Text(
              "Try diferente categories ",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: CustomAppBar(title: title!),
      body: ResponsiveBody(
        child: content,
      ),
    );
  }
}
