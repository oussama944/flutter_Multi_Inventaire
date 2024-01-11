import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inventaire_exo_muscu/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsItems extends StatelessWidget {
  const MealsItems({super.key, required this.meal});

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
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
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 50,
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
                    const Row(
                      children: [],
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
