import 'package:flutter/material.dart';
import 'package:untitled/data/models/event_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JoinEventPage extends StatelessWidget {
  const JoinEventPage({super.key});
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        actions: [],
        title: const Text("Join An Event"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Recipient Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: _connect(context, email: emailController),
                child: const Text("Connect"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _connect(
    context, {
    required TextEditingController email,
  }) {
    f() {
      final _email = email.text;

      if (_email.isEmpty || !_email.contains("@")) {
        Fluttertoast.showToast(
            msg: "Please submit a valid email", backgroundColor: Colors.red);
        return null;
      }
      return Navigator.of(context).pushNamed(
        "/event",
        arguments: EventModel.fromEmail(_email),
      );
    }

    return f;
  }
}
