import 'package:flutter/material.dart';
import 'package:wallpaper_app_flutter/widget/text/custom_text.dart';

class CategoryItem extends StatelessWidget {
  final String categoryTexts;
  const CategoryItem({
    Key key,
    this.categoryTexts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1.0, 1.0),
            color: Colors.grey.shade400,
            blurRadius: 5,
          )
        ],
      ),
      child: Center(
        child: CustomText(
          text: 'Cat',
          textSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
