import 'package:flutter/material.dart';

import './transaction_list.dart';
import './transaction.dart';
import './new_transaction.dart';





void main() => runApp(MyApp());



class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.black,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  caption: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
              )
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
              caption: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          )
      ),
    );
  }

}


class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
//commented the dummy transactions
    //  Transaction(id: '1', title: 'New Shoes', amount: 2.00, date: DateTime.now()),
    //  Transaction(id: '2', title: 'Watch', amount: 4.00, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount, DateTime chosenDate){
    final newTx = Transaction(title: title, amount: amount, id: DateTime.now().toString(), date: chosenDate);

    setState(() {
      this._userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
//it's been coming from material.dart
    showModalBottomSheet(
        context: ctx,
        builder: (_){
          return NewTransaction(this._addNewTransaction);
        });
  }

  void _deleteTransaction(String id){
//List has some pre-defined methods like removeWhere
    setState(() {
      this._userTransactions.removeWhere((tx) => id == tx.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter App',
        ),
//Now we are calling our function to open modal, instead of doing nothing
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TransactionList(this._userTransactions, this._deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),),
    );
  }
}