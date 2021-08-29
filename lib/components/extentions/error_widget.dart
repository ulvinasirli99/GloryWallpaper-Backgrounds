import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.error),
            Text("Something went wrong"),
          ],
        ),
      ),
    );
  }
}
