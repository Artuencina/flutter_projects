import "package:expense_tracker/widgets/chart/chart.dart";
import "package:expense_tracker/widgets/new_expense.dart";
import "package:flutter/material.dart";
import "package:expense_tracker/models/expense.dart";
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expensesList = [
    Expense(
        title: 'Hamburguesa',
        amount: 200,
        date: DateTime.now(),
        category: Category.comida),
    Expense(
        title: 'JBL',
        amount: 200,
        date: DateTime.now(),
        category: Category.otros),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseindex = _expensesList.indexOf(expense);
    setState(() {
      _expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Gasto eliminado"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Deshacer",
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseindex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openModalExpense() {
    //...
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainScreen = _expensesList.isNotEmpty
        ? ExpensesList(
            expenses: _expensesList,
            onRemoveExpense: _removeExpense,
          )
        : const Center(
            child: Text("No hay gastos"),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openModalExpense,
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _expensesList),
                Expanded(
                  child: mainScreen,
                ),
              ],
            )
          : Row(children: [
              Expanded(
                child: Chart(expenses: _expensesList),
              ),
              Expanded(
                child: mainScreen,
              ),
            ]),
    );
  }
}
