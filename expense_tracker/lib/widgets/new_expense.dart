import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _date;
  Category _category = Category.comida;

  void _showCalendarPicker() async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year, now.month);
    final lastDate = DateTime(now.year + 1, now.month);

    var selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: lastDate);

    setState(() {
      _date = selectedDate;
    });
  }

  void _submitExpenseData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (enteredTitle.isEmpty || amountInvalid || _date == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Valores invalidos"),
          content:
              const Text("Por favor ingrese un titulo, monto y fecha validos"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"))
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: _date!,
        category: _category));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController
        .dispose(); //Los controladores pueden permanecer incluso aunque el widget no sea visible. Por lo que se debe cerrar en el metodo dispose del widget State
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; //Obtiene el espacio que ocupa el teclado
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardSpace + 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                  maxLength: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            prefixText: "\$", labelText: "Monto"),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: _showCalendarPicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(_date == null
                              ? "Sin fecha"
                              : formatter.format(_date!)),
                        ),
                      ],
                    )),
                  ],
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: _category,
                      items: Category.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.name,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _category = value;
                        });
                      },
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text("Agregar"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancelar"),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
