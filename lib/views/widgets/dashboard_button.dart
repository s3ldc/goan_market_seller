
import 'package:flutter/material.dart';
import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';

Widget dashboardbutton(context,{title,count,Icons}){
  var size = MediaQuery.of(context).size;
  return  Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            boldText(text: title, size: 16.0),
            boldText(text: count, size: 20.0)
          ],
        ),
      ),
      Image.asset(
        Icons,
        width: 40,
        color: Colors.white,
      ),
    ],
  )
      .box
      .color(purpleColor)
      .size(size.width * 0.4, 80)
      .padding(EdgeInsets.all(8.0))
      .rounded
      .make();
}