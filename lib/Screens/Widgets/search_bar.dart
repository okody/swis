import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swis/Core/Constants/theme_constants.dart';

Widget SerachBar(context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: 50,
    
    padding: EdgeInsets.symmetric(horizontal: MainPadding / 4),
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(MainRadius / 4)),
    child: Row(children: [
      Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: MainPadding / 4,
          ),
          Container(
            width: 1.5,
            margin: EdgeInsets.symmetric(vertical: MainPadding / 4),
            color: Colors.white,
          )
        ],
      ),
      Expanded(
          child: TextField(
        textAlign: TextAlign.left,
        style: TextStyle(fontFamily: "main_font", fontSize: 15 , color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: MainPadding / 2),
            hintText: "Serach..",
            border: InputBorder.none,
            hintStyle: TextStyle(
                fontFamily: "main_font",
                color: Colors.white.withOpacity(0.5),
                fontSize: 15)),
      )),
      Icon(
        Ionicons.options,
        size: 30,
        color: Colors.white,
      ),
    ]),
  );
}
