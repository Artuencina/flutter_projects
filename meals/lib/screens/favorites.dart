import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return meals.isEmpty
        ? Center(
            child: Text(
              "No hay favoritos",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final meal = meals[index];
              return MealItem(
                meal: meal,
              );
            },
            itemCount: meals.length);
  }
}
