import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: color,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Provider.of<Settings>(context).isDarkMode
                    ? Colors.white
                    : Colors.purple,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
