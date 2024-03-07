//Vista para ver un lugar

import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(place.title,
                    style: Theme.of(context).textTheme.titleLarge)),
          ],
        ));
  }
}
