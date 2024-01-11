import 'package:flutter/material.dart';
import 'package:inventaire_exo_muscu/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      borderRadius:  BorderRadius.circular(70),
      splashColor: Theme.of(context).primaryColorDark,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.5),
            category.color.withOpacity(0.9),
          ]),
          borderRadius: BorderRadius.circular(20), // Bords arrondis
      //     boxShadow: const [
      //       BoxShadow(
      //       color: Colors.amber, //New
      //       blurRadius: 25.0,
      //       offset: Offset(0, 25))
      // ],
        ),
        child: Column(
          children: [
            Text(
              category.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  !.copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      ),
    );
  }
}
