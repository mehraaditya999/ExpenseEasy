import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenses_data.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<expense> _registeredExpenses = [
    expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.food),
    expense(
        title: 'anime_is_love',
        amount: 100.00,
        date: DateTime.now(),
        category: Category.leisure),
    expense(
        title: 'fast_food',
        amount: 25,
        date: DateTime.now(),
        category: Category.food)
  ];

  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => new_expense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(expense exp) {
    setState(() {
      _registeredExpenses.add(exp);
    });
  }

  void _removeExpense(expense exp) {
    final expenseIndex = _registeredExpenses.indexOf(exp);
    setState(() {
      _registeredExpenses.remove(exp);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds:3),
      content: const Text('Expense deleted.'),
      action: SnackBarAction(label: 'Undo',onPressed: (){
        setState(() {
          _registeredExpenses.insert(expenseIndex, exp);
        });
      }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent = const Center(
      child: Text('No Expenses found. Start adding some'),
    );

    if (_registeredExpenses.isNotEmpty) {
      maincontent = expense_list(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () {
                _openAddExpensesOverlay();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: maincontent,
          )
        ],
      ),
    );
  }
}
