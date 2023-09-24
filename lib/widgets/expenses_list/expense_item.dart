import 'package:expense_tracker/models/expenses_data.dart';
import 'package:flutter/material.dart';

class expenseitem extends StatelessWidget {
  const expenseitem(this.ex_penses, {Key? key}) : super(key: key);

  final expense ex_penses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ex_penses.title,style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\$${ex_penses.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                     Icon(categoryicons[ex_penses.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(ex_penses.formatted_date),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
