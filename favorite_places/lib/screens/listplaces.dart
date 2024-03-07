//Vista para ver todos los lugares
import 'package:favorite_places/bloc/placecubit.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/formplace.dart';
import 'package:favorite_places/screens/placescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPlaces extends StatelessWidget {
  const ListPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tus lugares'),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FormPlace()));
                }),
          ],
        ),
        body: BlocBuilder<PlaceCubit, List<Place>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return const Center(
                child: Text(
                  'No hay lugares',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: FileImage(state[index].image!),
                    ),
                    title: Text(state[index].title),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PlaceScreen(place: state[index])));
                    },
                    onLongPress: () {
                      context.read<PlaceCubit>().removePlace(state[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lugar eliminado'),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ));
  }
}
