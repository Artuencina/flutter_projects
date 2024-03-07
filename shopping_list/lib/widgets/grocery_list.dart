import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  var isLoading = true;

  List<GroceryItem> groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https('flutter-firebase-b369e-default-rtdb.firebaseio.com',
        'shopping-list.json');
    final response = await http.get(url);

    if (response.body == 'null') {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final Map<String, dynamic> listData = json.decode(response.body);

    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (element) => element.value.title == item.value['category'],
          )
          .value;

      loadedItems.add(
        GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category),
      );
    }

    setState(() {
      groceryItems = loadedItems;
      isLoading = false;
    });
  }

  void _addItem(BuildContext context) async {
    final newItem = await Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => const NewItem(),
    ));

    if (newItem != null) {
      setState(() {
        groceryItems.add(newItem);
      });
    }
  }

  void _removeItem(GroceryItem item) async {
    final url = Uri.https('flutter-firebase-b369e-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        groceryItems.remove(item);
      });
    } else if (response.statusCode == 404) {
      print('Item not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No hay items'),
    );

    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(groceryItems[index].id),
          onDismissed: (direction) {
            _removeItem(groceryItems[index]);
          },
          child: ListTile(
            title: Text(groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: groceryItems[index].category.color,
            ),
            trailing: Text(
              groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () {
              _addItem(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
