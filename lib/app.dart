import 'package:flutter/material.dart';
import 'package:untitled/data/models/event_model.dart';
import 'package:untitled/data/services/payment_service.dart';
import 'package:untitled/ui/screens/event_page.dart';
import 'package:untitled/ui/screens/home_page.dart';
import 'package:untitled/ui/screens/join_event_page.dart';
import 'package:untitled/ui/screens/landing_page.dart';
import 'package:untitled/ui/screens/payment.dart';
import 'package:untitled/ui/screens/register_page.dart';
import 'package:untitled/ui/screens/transactions_log.dart';

import 'data/providers/storage_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) {
          return const RegisterPage();
        },
        '/transactions': (BuildContext context) {
          return const TransactionsLogPage(title: 'My Transaction Logs');
        },
        '/homepage': (BuildContext context) {
          return const HomePage(
            title: 'welcome!',
          );
        },
        '/event/join': (BuildContext context) {
          return const JoinEventPage();
        },
        '/event': (BuildContext context) {
          final event =
              ModalRoute.of(context)!.settings.arguments as EventModel;
          return EventPage(event: event);
        },
        '/debit': (BuildContext context) {
          return WalletScreen();
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
        future: Future.wait([
          StorageProvider.initialize(),
          PaymentService.initialize(),
        ]),
      ),
      // home:LandingPage(),
    );
  }
}
