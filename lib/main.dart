import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_app_1/data/transaction.dart';
import 'package:real_app_1/widgets/chart.dart';
import 'package:real_app_1/widgets/new_transaction.dart';
import 'package:real_app_1/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'QuickSand',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    button: TextStyle(color: Colors.white),
                  ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [];
  bool _showChart = false;

  List<Transaction> get recentTransactionList {
    return transactions.where((element) {
      return element.date
          .subtract(
            Duration(days: 7),
          )
          .isBefore(DateTime.now());
    }).toList();
  }

  void _startNewTransaction(BuildContext mContext) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransactionList(_addNewTransaction);
        });
  }

  void _addNewTransaction(String name, double amount, DateTime date) {
    setState(() {
      print("here it comes");
      transactions.add(Transaction(
          id: DateTime.now().toString(),
          name: name,
          amount: amount,
          date: date));
    });
  }

  void _deleteTranscation(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaquery = MediaQuery.of(context);
    final AppBar appbar = AppBar(
      title: Text(
        'Personal Expense',
      ),
      actions: [
        IconButton(
            onPressed: () => _startNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    final txcontainer = Container(
        height: (mediaquery.size.height -
                appbar.preferredSize.height -
                mediaquery.padding.top) *
            0.75,
        child: TransactionList(transactions, _deleteTranscation));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (mediaquery.size.height -
                          appbar.preferredSize.height -
                          mediaquery.padding.top) *
                      0.25,
                  child: Chart(recentTransactionList)),
            if (!isLandscape) txcontainer,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaquery.size.height -
                              appbar.preferredSize.height -
                              mediaquery.padding.top) *
                          0.7,
                      child: Chart(recentTransactionList))
                  : txcontainer,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
