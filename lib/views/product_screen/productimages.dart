import 'package:flutter/cupertino.dart';
import 'package:goanmarketseller/const/colors.dart';
import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/consts/consts.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';

Widget productImage({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .size(16.0)
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
