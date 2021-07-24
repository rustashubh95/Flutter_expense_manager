import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_app_1/data/transaction.dart';
import 'package:real_app_1/widgets/chartbar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactionList;
  Chart(this.recentTransactionList);

  List<Map<String, Object>> get groupedTransactionList {
    return List.generate(7, (index) {
      final Weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalAmount = 0.0;
      for (int i = 0; i < recentTransactionList.length; i++) {
        if (recentTransactionList[i].date.day == Weekday.day &&
            recentTransactionList[i].date.month == Weekday.month &&
            recentTransactionList[i].date.year == Weekday.year) {
          totalAmount += recentTransactionList[i].amount;
        }
      }
      return {'day': DateFormat.E().format(Weekday), 'amount': totalAmount};
    }).reversed.toList();
  }

  double get maxSpending {
    double totalSpending = 0;

    for (int i = 0; i < recentTransactionList.length; i++) {
      totalSpending += recentTransactionList[i].amount;
    }
    return totalSpending;
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionList);
    // TODO: implement build
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionList.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  (data['day'] as String),
                  (data['amount'] as double),
                  maxSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
