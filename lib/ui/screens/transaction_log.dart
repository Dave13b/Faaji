import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/controllers/transaction_controller.dart';



class TransactionLogPage extends StatelessWidget {
   TransactionLogPage({Key? key, required this.title,}) : super(key: key);
  final String title;
  ValueNotifier<List>get logs=> TransactionController.instance.logs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Scrollbar(
        child: ListView.builder(itemBuilder: (BuildContext context,int index){
          final log=logs.value[index];
          return TransactionListTile(title: log['email'], subtitle: log['username'],);
        },
        ),
      ),
    );
  }
}

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({Key? key, required this.title,this.subtitle}) : super(key: key);
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
      subtitle: Text(subtitle??''),
      trailing:
         GestureDetector(
          onTap: () {
            throw UnimplementedError('rrrrrr');
          },
          child: const Text('Next'),
        ),

    );
  }
}