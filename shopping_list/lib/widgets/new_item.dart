import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();

  var isSending = false;

  String title = '';
  int quantity = 1;
  Category category = categories.values.first;

  void _saveItem() {
    //Retorna boolean, ejecuta el validador
    //de cada TextFormField
    if (_formKey.currentState!.validate()) {
      //Ejecuta el onSaved de todos los fields
      _formKey.currentState!.save();
      setState(() {
        isSending = true;
      });
      final url = Uri.https(
          'flutter-firebase-b369e-default-rtdb.firebaseio.com',
          'shopping-list.json');
      //Http
      http
          .post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {'name': title, 'quantity': quantity, 'category': category.title},
        ),
      )
          .then(
        (response) {
          final Map<String, dynamic> item = json.decode(response.body);

          if (!context.mounted) {
            return;
          }

          print(item['name']);
          Navigator.of(context).pop(GroceryItem(
              id: item['name'],
              name: title,
              quantity: quantity,
              category: category));
        },
      );
    } else {
      print('error');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        //Form
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                initialValue: title,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }

                  if (value.trim().length < 3) {
                    return 'Name must be at least 3 characters long';
                  }

                  if (value.trim().length > 50) {
                    return 'Name must be less than 50 characters long';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  title = newValue!;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Quantity"),
                      ),
                      initialValue: quantity.toString(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a quantity';
                        }

                        final quantity = int.tryParse(value);

                        if (quantity == null) {
                          return 'Please enter a valid quantity';
                        }

                        if (quantity < 1) {
                          return 'Please enter a quantity greater than 0';
                        }

                        return null;
                      },
                      onSaved: (newValue) => quantity = int.parse(newValue!),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: category,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {},
                      onSaved: (newValue) => category = newValue!,
                    ),
                  ),
                ],
              ),
              //Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: isSending
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: isSending ? null : _saveItem,
                    child: isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Save'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
