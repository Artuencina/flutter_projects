//Formulario para agregar un lugar

import 'dart:io';

import 'package:favorite_places/bloc/placecubit.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/image_picker.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPlace extends StatefulWidget {
  const FormPlace({super.key});

  @override
  State<FormPlace> createState() => _FormPlaceState();
}

class _FormPlaceState extends State<FormPlace> {
  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar lugar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nombre del lugar',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              //Foto
              InputImage(
                onImageSelected: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: 10),
              const LocationInput(),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    final newPlace = Place(
                      title: _titleController.text,
                      image: _selectedImage,
                      description: '',
                      latitude: 0,
                      longitude: 0,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nuevo lugar agregado'),
                      ),
                    );
                    context.read<PlaceCubit>().addPlace(newPlace);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Agregar lugar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
