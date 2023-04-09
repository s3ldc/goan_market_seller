import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goanmarketseller/services/store_services.dart';
import 'package:goanmarketseller/views/product_screen/product_detials.dart';
import 'package:goanmarketseller/views/widgets/loading_indicator.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import '../widgets/dashboard_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: boldText(text: dashboard, color: darkGrey, size: 16.0),
      ),
      body: StreamBuilder(
        stream: StoreServices.getproducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

            return Padding(
              padding: const EdgeInsets.all(9.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardbutton(context,
                          title: "Products", count: "${data.length}", Icons: icproducts),
                      dashboardbutton(context,
                          title: "Orders", count: "15", Icons: icorders),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardbutton(context,
                          title: "Total Sales", count: "60", Icons: icorders),
                      dashboardbutton(context,
                          title: "Rating", count: "15", Icons: icstar),
                    ],
                  ),
                  10.heightBox,
                  const Divider(),
                  10.heightBox,
                  boldText(
                    text: "Popular products",
                    color: darkGrey,
                    size: 16.0,
                  ),
                  20.heightBox,
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          data.length,
                          (index) => data[index]['p_wishlist'].length == 0
                              ? const SizedBox()
                              : ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(
                                    data[index]['p_imgs'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: '${data[index]['p_name']}',
                                      color: fontGrey,
                                      size: 14.0),
                                  subtitle: normalText(
                                      text: "${data[index]['p_price']}",
                                      color: darkGrey),
                                )),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
