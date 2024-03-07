//Picker para elegir una imagen
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImage extends StatefulWidget {
  const InputImage({super.key, required this.onImageSelected});

  //Funcion que recibe un File y lo envia a la vista padre
  final void Function(File image) onImageSelected;

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  bool isSelected = false;
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (image == null) {
      return;
    }

    setState(() {
      _selectedImage = File(image.path);
    });

    widget.onImageSelected(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: _selectedImage != null
          ? InkWell(
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
              //Si esta seleccionada la imagen, muestra
              //Un icono de borrar encima de la imagen
              //para eso se usa un Stack
              child: AnimatedCrossFade(
                crossFadeState: isSelected
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
                firstChild: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                secondChild: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.5)),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedImage = null;
                          isSelected = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
            )
          : TextButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text('Tomar foto'),
              onPressed: _takePicture,
            ),
    );
  }
}
