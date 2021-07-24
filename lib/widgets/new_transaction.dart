import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionList extends StatefulWidget {
  final Function newTransactionHandler;
  NewTransactionList(this.newTransactionHandler);
  @override
  _NewTransactionListState createState() {
    // TODO: implement createState
    return _NewTransactionListState();
  }
}

class _NewTransactionListState extends State<NewTransactionList> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;
  void _selectDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1998),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  void onDataSubmitted() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _textController.text;
    final enteredamount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredamount < 0.0 || selectedDate == null) {
      return;
    }
    widget.newTransactionHandler(enteredTitle, enteredamount, selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onSubmitted: (_) => onDataSubmitted(),
                controller: _textController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => onDataSubmitted(),
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Text(selectedDate == null
                        ? 'No Date Choosen!'
                        : DateFormat.yMMMd().format(selectedDate!)),
                    FlatButton(
                        onPressed: _selectDate,
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Select Date',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              RaisedButton(
                  onPressed: onDataSubmitted,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(
                    'Submit',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
