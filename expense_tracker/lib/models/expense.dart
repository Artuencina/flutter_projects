import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { comida, transporte, ropa, salud, entretenimiento, otros }

const categoryIcons = {
  Category.comida: Icons.fastfood,
  Category.transporte: Icons.directions_bus,
  Category.ropa: Icons.shopping_bag,
  Category.salud: Icons.medical_services,
  Category.entretenimiento: Icons.movie,
  Category.otros: Icons.money,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}

//Clase para los graficos de barra
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (Expense expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
