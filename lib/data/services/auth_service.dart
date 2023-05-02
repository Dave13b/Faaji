import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/data/Constants/index.dart' ;


class AuthService {
  Future<Map> login(String username, String password) async {
    final url =
    Uri.parse("https://celd.josephadegbola.com/wp-json/api/v2/user-auth/");
    final http.Response res = await http
        .post(url, body: {"user_login": username, "user_password": password});
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      final Map result = jsonDecode(res.body);
      return result;
    }
    String? message;
    try {
      final Map result = jsonDecode(res.body);
      message = result["message"] ?? "Invalid username or password";
    } catch (e) {
      message = "Unable to process login data";
    }
    throw Exception(message);
  }


  Future<dynamic> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      var url = Uri.parse(
          Constants.REGISTER_USER);
      Map body = {
        "email": email,
        "password": password,
        "username": username,
      };
      http.Response response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body)
      );
      debugPrint('this is the register response body');
      debugPrint(response.body);

      if (response.statusCode == 200) {
        dynamic result = jsonDecode(response.body);
        return result;
      }
      if (response.statusCode == 400) {
        dynamic result = jsonDecode(response.body);
        return result;
      }


    } catch (e) {
      debugPrint(e.toString());
    }
  }
}