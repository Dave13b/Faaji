import 'package:flutter/material.dart';
import 'package:untitled/data/models/event_model.dart';
import 'package:untitled/data/providers/wallet_provider.dart';
import 'package:untitled/ui/widgets/change_notifier_builder.dart';
import 'package:untitled/ui/widgets/swipe_detector.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class EventPage extends StatelessWidget {
  EventPage({
    super.key,
    required this.event,
  });
  final EventModel event;
  final amount = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text("Faaji"),
                      SizedBox(
                        child: VerticalDivider(
                          thickness: 3,
                          indent: 0,
                          color: Colors.green,
                        ),
                        height: 25,
                      ),
                      Text(event.email),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Amount Spent:"),
                          ChangeNotifierBuilder(
                              builder: (context, amount) => Text(
                                    amount.value.toString(),
                                  ),
                              listenable: amount)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SwipeDetector(
              child: Image(
                image: AssetImage('assets/images/kind.png'),
              ),
              onSwipeUp: _onSwipe,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: _close(context),
              child: const Text("Close Event"),
            )
          ],
        ),
      ),
    );
  }

  _close(context) {
    f() {
      Navigator.of(context).maybePop();
    }

    return f;
  }

  _onSwipe() async {
    Future<double?> getWalletBalanceFromSharedPreference() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var balance = preferences.getDouble('walletBalance');
      return balance;
    }

    Fluttertoast.showToast(
        msg: "50 naira has been sent to ${event.email} succcessfully");
    await WalletProvider.instance.debit(Uuid().v4(), 50);
    amount.value += 50;
  }
}
