import 'package:flutter/material.dart';

import './transaction_list.dart';
import './transaction.dart';



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

//Let's add demo list of transactions into a variable, it must be final
  final List<Transaction> _userTransactions = [
    Transaction(id: '1', title: 'New Shoes', amount: 2.00, date: DateTime.now()),
    Transaction(id: '2', title: 'Watch', amount: 4.00, date: DateTime.now()),
  ];

//adding a function into our file which needs to pass into the constructor of the transactions_list.dart file
  void _deleteTransaction(String id){
//  setState helps to re-render the class/widget
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => {},
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
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => {}),
    );
  }
}