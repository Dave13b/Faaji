import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/data/controllers/transaction_controller.dart';
import 'package:untitled/data/providers/auth_provider.dart';
import 'package:untitled/data/providers/wallet_provider.dart';
import 'package:untitled/data/services/payment_service.dart';
import '../../data/providers/storage_provider.dart';
import '../widgets/swipe_detector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _counter = 0;
  int? _balanceRetrieved = 0;
  int _counter = 50;
  bool _refresh = false;
  final amountController = TextEditingController();
  num get fundingAmount => num.tryParse(amountController.text) ?? 0;
  @override
  void didChangeDependencies() {
    if (_refresh) {
      setState(() {
        _balanceRetrieved = StorageProvider.instance.getInt('walletBalance');
        _counter = _balanceRetrieved!;
      });
    }
    print(AuthProvider.instance.session?.userId);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    final counter = StorageProvider.instance.getDouble('_counter');
    setState(() {
      _balanceRetrieved = StorageProvider.instance.getInt('walletBalance') ?? 0;
      _counter = _balanceRetrieved!;
    });
    if (counter != null) {
      _counter = counter as int;
    }
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Object? refresh = ModalRoute.of(context)?.settings.arguments;
    if (refresh != null) {
      _refresh = _refresh;
    }
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: AuthProvider.instance.logout, icon: Icon(Icons.logout))
        ],
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: SwipeDetector(
          onSwipeUp: () {
            debugPrint("swiped");
            _incrementCounter();
          },
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Wallet balance'
                    ':',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: WalletProvider.instance.balance,
                      builder: (__, _, w) => Text(
                            _.toString(),
                            style: Theme.of(context).textTheme.headline4,
                          )),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter an amount',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                if (fundingAmount <= 0) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter a valid amount");
                                  return;
                                }
                                PaymentService.instance
                                    .fundWalletWithPaystack(
                                        context,
                                        fundingAmount,
                                        AuthProvider.instance.session!.email!,
                                        (Random().nextInt(999999) * 999999)
                                            .toString())
                                    .then((result) {
                                  if (result.status) {
                                    WalletProvider.instance
                                        .fund(result.reference!, fundingAmount);
                                  }
                                });
                              },
                              child: Text("Fund Wallet"),
                            )),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/transactions');
                            },
                            child: Text('Transaction Logs')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/event/join');
          },
          tooltip: 'Fund Wallet',
          child: Center(
              child:
                  SizedBox(child: const Icon(Icons.monetization_on_outlined)))),
    );
  }

  Future<double?> getWalletBalanceFromSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var balance = preferences.getDouble('walletBalance');
    return balance;
  }
}
