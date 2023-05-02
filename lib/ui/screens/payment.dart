import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/data/providers/wallet_provider.dart';
import 'package:untitled/ui/widgets/swipe_detector.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'dart:math';
import '../../app.dart';
import '../../data/providers/storage_provider.dart';
import '../../widget.dart';


class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  void initState() {

    super.initState();
  }

  onSwipe (){
    Future<double?> getWalletBalanceFromSharedPreference()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var balance= preferences.getDouble('walletBalance');
      return balance;
    }
    Fluttertoast.showToast(msg: '50 naira has been debited succcessfully');
    WalletProvider.instance.debit(Uuid().v4(), 50);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){ Navigator.pop(context, true);},) ,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Current balance:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),


          ),
          ValueListenableBuilder(valueListenable: WalletProvider.instance.balance,builder:(__,_,w)=>Text(_.toString(),
            style: Theme.of(context).textTheme.headline4,
          )),
          Expanded(child: SwipeDetector(
            child: Image(
              image: AssetImage('assets/images/kind.png'),
            ),
            onSwipeUp: onSwipe,)),

        ],
      ),
    );
  }

  Widget _createTextField({
    required String hintText,
    TextEditingController? controller,
    bool obscureText = false,
    String? Function(String? value)? validator,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.white,
          hintText: hintText,
        ),
      ),
    );
  }
}
