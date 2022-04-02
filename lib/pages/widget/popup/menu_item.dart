import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/widget/text/gradinet_text.dart';

class MenuItem extends StatelessWidget {
  final IconData ?icon;
  final Color? color;
  final String ?title;
  final VoidCallback? onTap;

  const MenuItem({Key? key, this.icon, this.title, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(top: 8),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
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
              Provider.of<Settings>(context).isDarkMode
                  ? Text(
                      title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    )
                  : GradientText(
                      text: title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        letterSpacing: 1.0,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade400,
                          Colors.purple.shade400,
                          Colors.blueAccent.shade700,
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
