import 'package:flutter/material.dart';
import 'package:untitled/data/services/payment_service.dart';
import 'package:untitled/ui/screens/home_page.dart';
import 'package:untitled/ui/screens/landing_page.dart';
import 'package:untitled/ui/screens/payment.dart';
import 'package:untitled/ui/screens/register_page.dart';
import 'package:untitled/ui/screens/transaction_log.dart';

import 'data/providers/storage_provider.dart';
import '';


class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) {
          return RegisterPage();


        },

        '/transaction':(BuildContext context){
          return TransactionLogPage(title: 'My Transaction Logs');
        },
        '/homepage': (BuildContext context) {
          return const HomePage(title: 'welcome!',);

        },
        // '/checkout': (BuildContext context) {
        //   return PaymentPage();
        //
        // },


        '/debit':(BuildContext context){
          return WalletScreen ();
        }


      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: FutureBuilder(
        builder: (context, snapshot) =>
        snapshot.connectionState == ConnectionState.done
            ? LandingPage()
            : const Center(
          child: CircularProgressIndicator(),
        ),
        future:Future.wait([StorageProvider.initialize(), PaymentService.initialize(),]),
      ),
      // home:LandingPage(),
    );
  }
}


