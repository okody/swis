import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:search_page/search_page.dart';
import 'package:swis/Core/Constants/theme_constants.dart';

Widget SerachBar<T>(context, {required List<T> items, filter, builder}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: kMainPadding / 4),
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(kMainRadius / 4)),
    child: Row(children: [
      Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          const SizedBox(
            width: kMainPadding / 4,
          ),
          Container(
            width: 1.5,
            margin: const EdgeInsets.symmetric(vertical: kMainPadding / 4),
            color: Colors.white,
          )
        ],
      ),
      Expanded(
          child: TextField(
        onTap: () {
          showSearch(
              context: context,
              delegate: SearchPage<T>(
                items: items,
                barTheme: ThemeData(
                  
                  scaffoldBackgroundColor: kBetaColor,
                  appBarTheme: AppBarTheme(backgroundColor: kAlphaColor),
                ),
                searchLabel: 'Search',
                searchStyle: TextStyle(color: Colors.white),
                
                suggestion: const Center(
                  child: Text("Use device id to search"),
                ),
                failure: const Center(
                  child: Text('Nothing found :('),
                ),
                filter: filter,
                builder: builder,
              ));
        },
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontFamily: "main_font", fontSize: 15, color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: kMainPadding / 2),
            hintText: "Search".tr + "..",
            border: InputBorder.none,
            hintStyle: TextStyle(
                fontFamily: "main_font",
                color: Colors.white.withOpacity(0.5),
                fontSize: 15)),
      )),
      const Icon(
        Ionicons.options,
        size: 30,
        color: Colors.white,
      ),
    ]),
  );
}
