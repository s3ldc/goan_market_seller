import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goanmarketseller/views/controllers/auth_controller.dart';
import 'package:goanmarketseller/views/controllers/profile_controller.dart';
import 'package:goanmarketseller/views/profile_screen/edit_profile_screen.dart';
import 'package:goanmarketseller/views/shop_screen/shop_settings_screen.dart';
import 'package:goanmarketseller/views/widgets/loading_indicator.dart';
import '../../const/const.dart';
import '../../services/store_services.dart';
import '../auth_screen/login_screen.dart';
import '../messages_screen/message_screen.dart';
import '../widgets/normal_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        actions: [
          10.widthBox,
          IconButton(
            onPressed: () {
              Get.to(() => EditProfileScreen(
                  username: controller.snapshotData['vendor_name']));
            },
            icon: const Icon(Icons.edit),
          ),
          TextButton(
            onPressed: () async {
              await Get.find<AuthController>().signoutMethod(context);
              Get.offAll(() => const LoginScreen());
            },
            child: normalText(text: 'Logout'),
          ),
        ],
        automaticallyImplyLeading: false,
        title: boldText(text: "Settings", color: white, size: 16.0),
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator(circle_Color: white);
          } else {
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotData['imageUrl'] == ' '
                      ? Image.asset(
                          imgproduct,
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.network(controller.snapshotData['imageUrl'],
                          width: 100,).box.roundedFull.clip(Clip.antiAlias).make(),
                  title: boldText(text: "${controller.snapshotData['vendor_name']}"),
                  subtitle: normalText(text: "${controller.snapshotData['email']}"),
                ),
                const Divider(),
                10.heightBox,
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              profilebuttontitles.length,
                              (index) => ListTile(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() => const ShopSettings());
                                          break;
                                        case 1:
                                          Get.to(() => const MessagesScreen());
                                      }
                                    },
                                    leading:
                                        Icon(profilebuttonIconslist[index],color: Colors.white,),
                                    title: normalText(
                                        text: profilebuttontitles[index],
                                        color: white,
                                        size: 14.0),
                                  )),
                        )
                      ],
                    ))
              ],
            );
          }
        },
      ),
    );
  }
}
