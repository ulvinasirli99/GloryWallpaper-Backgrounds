import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitNetworkData extends StatelessWidget {
  var waitSpin = SpinKitCircle(
    duration: Duration(milliseconds: 1000),
    size: 70,
    color: Colors.redAccent[700],
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
      ),
      child: waitSpin,
    );
  }
}
