import 'package:flutter/material.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/favorites.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _filters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            filters: _filters,
          ),
        ),
      );
      setState(() {
        _filters = result ?? kInitialFilters;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Widget? activePage;
    var activePageTitle = 'Categorias';

    //Usar el provider
    final meals = ref.watch(mealsProvider);

    final filteredMeals = meals.where((meal) {
      if (_filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    switch (_selectedPageIndex) {
      case 0:
        activePage = CategoriesScreen(
          availableMeals: filteredMeals,
        );
        activePageTitle = 'Categorias';
        break;
      case 1:
        final favoriteMeals = ref.watch(favoritesMealProvider);
        activePage = FavoritesScreen(
          title: 'Favoritos',
          meals: favoriteMeals,
        );
        activePageTitle = 'Favoritos';
        break;
      default:
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSetScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
        ],
      ),
      body: activePage,
    );
  }
}
