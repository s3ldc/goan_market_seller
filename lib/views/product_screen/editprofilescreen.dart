import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/views/widgets/custom_textfield.dart';

import '../widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purpleColor,
        actions: [
          10.widthBox,
          TextButton(
              onPressed: () {}, child: normalText(text: "Save", color: white))
        ],
        automaticallyImplyLeading: false,
        title: boldText(text: "Edit Profile", color: white, size: 16.0),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(imgproduct)
                .box
                .width(150)
                .roundedFull
                .clip(Clip.antiAlias)
                .make(),
            10.heightBox,
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: purpleColor,
                ),
                onPressed: () {},
                child: normalText(text: "Change Image")),
            10.heightBox,
            Divider(
              color: white,
            ),
            CustomeTextField(label:"Name",hint: "eg. Username"),
            10.heightBox,
            CustomeTextField(label:"Password",hint: passwordhint),10.heightBox,
            CustomeTextField(label:"Confirm Password",hint: passwordhint),10.heightBox,
          ],
        ),
      ),
    );
  }
}
