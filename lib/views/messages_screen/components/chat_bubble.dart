import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';

Widget chatbubble(){
  return Directionality(
    // textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    textDirection: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
          // color: data['uid'] == currentUser!.uid ? Colors.red : darkFontGrey,
          color:purpleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "${data['msg']}".text.white.size(16).make(),
          normalText(text: "Your message here... "),
          10.heightBox,

          // time.text.color(whiteColor.withOpacity(0.5)).make()
          normalText(text: "12:00 PM")
        ],
      ),
    ),
  );
}