import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSetScreen,
  });

  final void Function(String identifier) onSetScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.fastfood, size: 48, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  'Recetas',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant,
                color: Theme.of(context).colorScheme.primary),
            title: Text(
              "Recetas",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontSize: 24),
            ),
            onTap: () {
              onSetScreen('meals');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.primary),
            title: Text(
              "Filtros",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontSize: 24),
            ),
            onTap: () {
              onSetScreen('filters');
            },
          )
        ],
      ),
    );
  }
}
