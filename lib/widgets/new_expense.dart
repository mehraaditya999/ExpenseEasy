import 'package:expense_tracker/models/expenses_data.dart';
import 'package:flutter/material.dart';

class new_expense extends StatefulWidget {
  const new_expense({Key? key, required this.onAddExpense,}) : super(key: key);

  final void Function(expense exp) onAddExpense;


  @override
  State<new_expense> createState() => _new_expenseState();
}

class _new_expenseState extends State<new_expense> {
  final _titalController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedExpense = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titalController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (cts) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title/amount/date was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(cts);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(expense(
        title: _titalController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedExpense));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titalController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titalController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected '
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: () {
                          _presentDatePicker();
                        },
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Row(
              children: [
                DropdownButton(
                    value: _selectedExpense,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedExpense = value;
                      });
                    }),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    _submitExpenseData();
                  },
                  child: const Text('Save Expense')),
            ],
          ),
        ],
      ),
    );
  }
}
