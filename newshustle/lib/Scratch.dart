import 'package:flutter/material.dart';

class TestingFCM extends StatelessWidget {
  final String title;
  final String message;

  const TestingFCM(this.title, this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.message),
          Text(this.title)
        ],
      ),
    );
  }
}
