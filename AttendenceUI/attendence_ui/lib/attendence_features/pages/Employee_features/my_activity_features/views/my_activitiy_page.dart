import 'package:flutter/material.dart';

class MyActivitiyPage extends StatelessWidget {
  const MyActivitiyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My activity page'),

      ),
      body: Center(
        child: Text('Activities'),
      ),
    );
  }
}

