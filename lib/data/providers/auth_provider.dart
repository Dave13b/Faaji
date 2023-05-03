import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled/data/models/session_model.dart';
import 'package:untitled/data/providers/storage_provider.dart';
import 'package:untitled/data/providers/wallet_provider.dart';
import 'package:untitled/data/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoggedIn = false;
  String? username;
  String? password;
  String? email;
  final service = AuthService();

  set session(SessionModel? result) => StorageProvider.instance
      .setString("session", jsonEncode(result?.toMap()));
  SessionModel? get session {
    final result = StorageProvider.instance.getString("session");
    if (result == null) return null;
    final json = jsonDecode(result) as Map?;
    if (json == null) return null;
    print(json);
    return SessionModel.fromMap(json);
  }

  checkLoginState() {
    isLoggedIn = session != null;
    notifyListeners();
  }

  balanceNotifier() {
    StorageProvider.instance.setDouble("${session!.userId}_user_balance",
        WalletProvider.instance.balance.value.toDouble());
  }

  updateBalance() {
    WalletProvider.instance.balance.value = StorageProvider.instance.getDouble(
          "${session!.userId}_user_balance",
        ) ??
        0;
  }

  Future<String?> login(String username, String password) async {
    final result = await service.login(username, password);
    session = SessionModel.fromMap(result);
    print(result);
    this.username = username;
    this.password = password;
    isLoggedIn = true;
    notifyListeners();
    WalletProvider.instance.balance.addListener(balanceNotifier);
    updateBalance();
    if (result?['user']?['is_verified'] == true) return "Welcome $username!";
  }

  Future<dynamic> register(
      String username, String email, String password) async {
    final result = await service.register(
        email: email, password: password, username: username);
    notifyListeners();
    WalletProvider.instance.balance.addListener(balanceNotifier);
    return result;
  }

  logout() {
    username = null;
    password = null;
    isLoggedIn = false;
    session = null;
    notifyListeners();
  }

  static AuthProvider instance = _initialize();
  static AuthProvider _initialize() {
    return AuthProvider();
  }
}
