import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expenses_data.dart';

class expense_list extends StatelessWidget {
  const expense_list(
      {Key? key, required this.expenses, required this.onRemoveExpense})
      : super(key: key);

  final List<expense> expenses;
  final void Function(expense exp) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          background: Container(

            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.error,
            ) ,
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: expenseitem(
            expenses[index],
          )),
    );
  }
}
