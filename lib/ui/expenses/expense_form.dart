import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreateExpense});

  final void Function(Expense) onCreateExpense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose(){
    super.dispose();

    _titleController.dispose();
  }

  void onCreate() {
    //  1 Build an expense
    String  title = _titleController.text;
    double? amount = double.tryParse(_amountController.text);             // for now..
    Category category =Category.food;   // for now..
    DateTime date = DateTime.now();

    if (amount == null || amount <= 0 || title.trim().isEmpty) {
      // show error
      return;
    }

    // ignore: unused_local_variable
    Expense newExpense = Expense(title: title, amount: amount, date: date, category: category);

    // TODO YOUR CODE HERE
    widget.onCreateExpense(newExpense);
    // Close the modal
    Navigator.pop(context);
  }
  
  void onCancel() {
    // Close the modal
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(label: Text("Amount")),
            keyboardType: TextInputType.number,
            maxLength: 50,
          ),
          ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
          SizedBox(width: 10,),
          ElevatedButton(onPressed: onCreate, child: Text("Create")),
        ],
      ),
    );
  }
}
