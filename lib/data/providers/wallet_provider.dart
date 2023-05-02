import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/data/providers/storage_provider.dart';
import 'package:untitled/data/services/wallet_service.dart';

class WalletProvider extends ChangeNotifier {
  ValueNotifier <num> balance = ValueNotifier(0);
  final WalletService service = WalletService();
  static  final WalletProvider instance=initialize();


  Future<String?> fund(String reference, num amount) async {
    balance.value+=amount;
   // final result = await service.fund(reference, amount);
    notifyListeners();
      return "Wallet funding successful!";
  }

  Future<String?> debit(String reference, num amount) async {
    balance.value-=amount;
   // final result = await service.debit(reference,amount);
    notifyListeners();
    return "Debit wallet successful";
  }

  static WalletProvider initialize()  {
    return WalletProvider();
  }
}

