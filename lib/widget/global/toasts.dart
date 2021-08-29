import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void error(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: Colors.black,
  );
}

Future notificationMessage(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: Colors.black,
  );
}

void hasConnected(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    backgroundColor: Colors.red[400],
  );
}

void codeSend(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      backgroundColor: Colors.green[400]);
}
