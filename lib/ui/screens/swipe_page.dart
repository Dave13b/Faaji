import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SwipePage extends StatelessWidget {
  const SwipePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SwipePage(title: 'SwipePage');
              }));
            };
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
