import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goanmarketseller/services/store_services.dart';
import 'package:goanmarketseller/views/order_screen/order_details.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import '../controllers/orders_controller.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/normal_text.dart';

class orderScreen extends StatelessWidget {
  const orderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ordercontroller());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Center(
              child: normalText(
                  text: intl.DateFormat('EEE, MMM d, ' 'yy')
                      .format(DateTime.now()),
                  color: purpleColor),
            ),
            10.widthBox
          ],
          automaticallyImplyLeading: false,
          title: boldText(text: "Orders", color: darkGrey, size: 16.0),
        ),
        body: StreamBuilder(
          stream: StoreServices.getorders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LoadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(data.length, (index) {
                        var time = data[index]['order_date'].toDate();
                        return ListTile(
                          onTap: () {
                            Get.to(() => Orderdetails(data: data[index],));
                          },
                          tileColor: textfieldGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: boldText(
                              text: '${data[index]['order_code']}',
                              color: purpleColor,
                              size: 14.0),
                          subtitle: Column(
                            children: [
                              Row(children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: fontGrey),
                                // normalText(text: "\$40.0", color: darkGrey)
                              ]),
                              Row(children: [
                                const Icon(
                                  Icons.payment,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(text: "Unpaid", color: red),
                                // normalText(text: "\$40.0", color: darkGrey)
                              ]),
                            ],
                          ),
                          trailing: boldText(
                              text: ' ${data[index]['total_amount']}', color: purpleColor, size: 16.0),
                        );
                      }),
                    ),
                  ));
            }
          },
        ));
  }
}
