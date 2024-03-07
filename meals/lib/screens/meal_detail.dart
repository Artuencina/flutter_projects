import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final added =
                  ref.read(favoritesMealProvider.notifier).toggleFavorite(meal);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(added
                      ? 'Agregado a favoritos'
                      : 'Eliminado de favoritos'),
                  showCloseIcon: true,
                ),
              );
            },
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.network(
            meal.imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            'Ingredientes',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 10),
          for (final ingredient in meal.ingredients)
            Text(
              ingredient,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          const SizedBox(height: 10),
          Text(
            'Pasos',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          for (final step in meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: Text(
                step,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
        ],
      ),
    );
  }
}
