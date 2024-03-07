import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.filters,
  });

  final Map<Filter, bool> filters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.filters[Filter.glutenFree]!;
    _lactoseFree = widget.filters[Filter.lactoseFree]!;
    _vegetarian = widget.filters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtros"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFree,
            Filter.lactoseFree: _lactoseFree,
            Filter.vegetarian: _vegetarian,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFree,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFree = isChecked;
                });
              },
              title: Text(
                "Sin gluten",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Solo incluye comidas sin gluten',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _lactoseFree,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFree = isChecked;
                });
              },
              title: Text(
                "Sin lactosa",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Solo incluye comidas sin lactosa',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
            SwitchListTile(
              value: _vegetarian,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarian = isChecked;
                });
              },
              title: Text(
                "Vegetariano",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Solo incluye comidas vegetarianas',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
