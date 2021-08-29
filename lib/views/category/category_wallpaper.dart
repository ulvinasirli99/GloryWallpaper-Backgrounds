import 'package:flutter/material.dart';

Center categoryWallpaper({String cateName, String imgUrl}) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 7),
        width: 100,
        height: 55,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              imgUrl,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            cateName,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
