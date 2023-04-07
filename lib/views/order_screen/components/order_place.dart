import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';

Widget orderPlaceDetails({title1,title2,d1,d2}){
  return Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          boldText(text: title1,color: purpleColor),
          boldText(text: d1,color: red)
        ],
      ),
      SizedBox(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: title2,color: purpleColor),
            boldText(text: d2,color: fontGrey)          ],
        ),
      )
    ],
  ),
  );
}