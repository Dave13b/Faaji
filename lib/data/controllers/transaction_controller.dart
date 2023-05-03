import 'package:flutter/cupertino.dart';
import 'package:faker/faker.dart';

class TransactionController extends ChangeNotifier {
  final ValueNotifier<List<Map<String, dynamic>>> logs = ValueNotifier(
    List.generate(
        10,
        (index) => {
              'email': faker.internet.email(),
              'fullname': faker.person.name(),
              'amount': faker.randomGenerator.amount((i) => null, 1000),
            }),
  );

  static final TransactionController instance = _initialize();

  static TransactionController _initialize() {
    return TransactionController();
  }
}
