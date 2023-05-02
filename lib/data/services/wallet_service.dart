import 'dart:convert';

import 'package:http/http.dart' as http;

class WalletService {
  Future<Map> fund (String reference, String amount) async {
    final url =
    Uri.parse("https://celd.josephadegbola.com/wp-json/api/v2/user-auth/");
    final http.Response res = await http
        .post(url, body: {"reference": reference, "amount": amount});
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



  Future<Map> debit (String reference, String amount) async {
    final url =
    Uri.parse("https://celd.josephadegbola.com/wp-json/route/v2/addcustomer");
    final http.Response res = await http
        .post(url, body: {"reference":reference , "amount": amount});
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
      message = "Unable to process register data";
    }
    throw Exception(message);
  }

}
