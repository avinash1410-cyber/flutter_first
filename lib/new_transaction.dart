import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime(2022);
  

  void _submitData() {
    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = this._titleController.text;
    final enteredAmount = double.parse(this._amountController.text);

//adding the validations for form
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

//this is how we use the variables from the stateful class into its state class
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

//we use pop function of Navigator to close this modal after submitting
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          this._selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
//we use _(underscore) in argument if we don't want to mess with the parameter which is coming from its call
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen!'
                        : 'Selected Date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                TextButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _presentDatePicker,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent, // if you want to change button colour
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('Add Transaction'),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightGreenAccent, // Background color
              onPrimary: Colors.amber, // Text Color (Foreground color)
            ),
            onPressed: _submitData,
          ),
        ],
      ),
    );
  }
}