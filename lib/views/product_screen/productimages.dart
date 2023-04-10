import 'package:goanmarketseller/const/const.dart';

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
