import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';

void main()
{
  runApp (App());
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title:TextStyle(fontFamily: 'Opensans',
          fontSize: 18,
          fontWeight: FontWeight.bold
          ),
          button: TextStyle(color:Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title:TextStyle(fontFamily: 'Opensans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
          ),
        )
      ),
      home: Myapp(),
      
    );
  }
}

class Myapp extends StatefulWidget {
  

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  final List<Transaction> _usertransaction = [
    //  Transaction(
    //     id:'t1',
    //     title: 'New Shoes',
    //     amount: 999.9,
    //     date: DateTime.now(),
        
    //   ),
    //    Transaction(
    //     id:'t2',
    //     title: 'Gooeries',
    //     amount: 50.99,
    //     date: DateTime.now(),
        
    //   ),
  ];
  List<Transaction> get _recentTransaction
  {
    return _usertransaction.where((tx)
    {
      return tx.date.isAfter(
        DateTime.now().subtract(
        Duration(days:7),
        ),
        );
    }).toList();
  }

  void _addNewTransaction(String txtitle,double amu,DateTime chosenDate)
  {
    final ptx = Transaction(
      id:  DateTime.now().toString(), 
      title:txtitle, 
      amount: amu, 
      date: chosenDate,
      );
      setState((){
        _usertransaction.add(ptx);
      });
      

  }
  void _startShowAddTransaction(BuildContext ctx)
  {
    showModalBottomSheet(
      context: ctx, builder: (bctx)
    {
      return GestureDetector(
        onTap:(){},
        child:NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
        );
    },
    );
  }
  void _deleteTransaction(String id)
  {
    setState(() {
      _usertransaction.removeWhere((tx)
      {
        return tx.id==id;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:
    Scaffold(
      appBar: AppBar(
        title: Text('Daily Expense'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
           onPressed:()=>_startShowAddTransaction(context),
           )
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTransaction),
             TransactionList(_usertransaction,_deleteTransaction),
          ],
          ),
      ),
    
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add
        ),
        onPressed:() => _startShowAddTransaction(context),   
      ),
    ),
    );
  }
}