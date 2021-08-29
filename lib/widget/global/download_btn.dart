import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
          child: Container(
          margin: EdgeInsets.only(bottom: 50),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.orange,
          ),
          child: Center(
            child: Icon(Icons.home)
          ),
      ),
    );
  }
}
