import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_app_1/data/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetransaction;
  TransactionList(this.transactions, this.deletetransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctz, constrainst) {
              return Column(
                children: [
                  Text(
                    'NO EXPENSES YET!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: constrainst.maxHeight * 0.15,
                  ),
                  Container(
                    height: constrainst.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? FlatButton.icon(
                            onPressed: () {
                              deletetransaction(transactions[index].id);
                            },
                            textColor: Theme.of(context).errorColor,
                            icon: Icon(Icons.delete),
                            label: Text('Delete'))
                        : IconButton(
                            onPressed: () {
                              deletetransaction(transactions[index].id);
                            },
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
