import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((element) => meal.id != element.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealProvider =
    StateNotifierProvider<FavoritesMealNotifier, List<Meal>>(
  (ref) => FavoritesMealNotifier(),
);
