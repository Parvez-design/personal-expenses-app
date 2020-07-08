import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Container(
                  child: Text(
                "No transactions added yet!",
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ));
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('${transactions[index].amount}/-'),
                      ),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    transactions[index].title,
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id)),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}