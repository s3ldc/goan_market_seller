import 'package:flutter/cupertino.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';

AppBar appBarWidget (title){
  return  AppBar(
    actions: [
      Center(
        child: normalText(
            text:
            intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
            color: purpleColor),
      ),
      10.widthBox
    ],
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: darkGrey, size: 16.0),
  );

}