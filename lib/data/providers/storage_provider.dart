import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends ChangeNotifier{
  static late final SharedPreferences instance;
  static Future initialize() async {
    final pref=await SharedPreferences.getInstance();
    instance=pref;
  }
}


