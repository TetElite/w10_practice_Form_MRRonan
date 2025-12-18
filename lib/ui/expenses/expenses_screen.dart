import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'expense_form.dart';
import 'expense_item.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void onAddClicked(BuildContext context) {
    showModalBottomSheet<Expense>(
      isScrollControlled: false,
      context: context,
      builder: (c) => ExpenseForm(
        onCreateExpense: (newExpense) {
          setState(() {
            _expenses.add(newExpense);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => {onAddClicked(context)},
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: _expenses.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No expenses yet. Tap + to add your first one!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) => ExpenseItem(
                expense: _expenses[index],
                onSlideAway: (Expense removed) {
                  final removedIndex = _expenses.indexOf(removed);
                  setState(() {
                    _expenses.removeAt(removedIndex);
                  });

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Expense removed'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          setState(() {
                            _expenses.insert(removedIndex, removed);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
