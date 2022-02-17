import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';



class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

//constructor
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        child: this.transactions.isEmpty ? Column(
          children: <Widget>[
            Text(
              'No Transactions added yet!',
//this is how we use our theme from main.dart file
              style: Theme.of(context).textTheme.caption,
            ),
//Used to give some vertical space
            SizedBox(
              height: 60,
            ),
            Container(
              height: 400,
//Use of our image which we had configured
              child: Image.asset(
                'assets/images/waiting.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ) :
//ListView.builder is a way of constructing the list where children’s (Widgets) are built on demand. However, instead of returning a static widget, it calls a function which can be called multiple times (based on itemCount ) and it’s possible to return different widget at each call.
        ListView.builder(
          itemBuilder: (ctx, index){
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(child: Text('\$${transactions[index].amount}')),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.caption,
                ),
//Use of intl library, DateFormat is coming from intl
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deleteTx(this.transactions[index].id),
                ),
              ),
            );
          },
          itemCount: transactions.length,
        )
    );
  }
}




