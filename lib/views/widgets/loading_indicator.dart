
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goanmarketseller/const/colors.dart';

Widget LoadingIndicator({circle_Color = purpleColor}){
  return  Center(
    child:CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circle_Color),
    ),
  );
}