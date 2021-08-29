import 'package:flutter/material.dart';

class DrawerProTile extends StatelessWidget {
  final String assetImagePath;
  final String tittle;
  final Function function;

  const DrawerProTile(
      {Key key, this.assetImagePath, this.tittle, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Image.asset(
              assetImagePath,
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              tittle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.purple,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
