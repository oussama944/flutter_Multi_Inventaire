import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inventaire_exo_muscu/models/meal.dart';
import 'package:inventaire_exo_muscu/widgets/meals_item_trait.dart';

class MealsItems extends StatelessWidget {
  const MealsItems({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;

  final void Function(  Meal meal) onSelectMeal;

  

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            // FadeInImage(
            //   placeholder: MemoryImage(kTransparentImage),
            //   image: NetworkImage(meal.imageUrl),
            // ),
            CachedNetworkImage(
              imageUrl: meal.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              placeholderFadeInDuration: const Duration(milliseconds: 500),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error, size: 100.0),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 20,
              left: 5,
              right: 5,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        MealsItemsTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 5),
                        MealsItemsTrait(
                          icon: Icons.work,
                          label: '$complexityText ',
                        ),
                        const SizedBox(width: 5),
                        MealsItemsTrait(
                          icon: Icons.euro,
                          label: '$affordabilityText ',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
