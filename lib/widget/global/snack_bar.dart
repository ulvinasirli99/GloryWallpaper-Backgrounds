import 'package:flutter/material.dart';

 void snackBar(String text,GlobalKey<ScaffoldState> scfaffoldKey) {
    scfaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(text),
        backgroundColor: Colors.teal,
      ),
    );
  }