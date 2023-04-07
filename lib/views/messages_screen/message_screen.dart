import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goanmarketseller/services/store_services.dart';
import 'package:goanmarketseller/views/messages_screen/chat_screen.dart';
import 'package:goanmarketseller/views/widgets/loading_indicator.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import '../widgets/normal_text.dart';


class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(icon: const Icon(Icons.arrow_back, color: darkGrey),onPressed: (){
          Get.back();
        },),
        backgroundColor: purpleColor,
        actions: [
          10.widthBox,
          TextButton(
              onPressed: () {}, child: normalText(text: "Save", color: white))
        ],
        title: boldText(text: "Messages ", color: white, size: 16.0),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessages(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                      data.length,
                          (index){
                        var t = data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
                        var time = intl.DateFormat('h:mma').format(t);
                            return ListTile(
                              onTap: (){
                                Get.to(() => const ChatScreen());
                              },
                              leading: const CircleAvatar(
                                  backgroundColor: purpleColor,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )),
                              title: boldText(
                                  text: "${data[index]['sender_name']}",
                                  color: fontGrey,
                                  size: 14.0),
                              subtitle: normalText(
                                  text: "${data[index]['last_msg']}",
                                  color: darkGrey),
                              trailing: normalText(text: time, color: darkGrey),
                            );
                          }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
