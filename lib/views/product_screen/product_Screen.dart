import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goanmarketseller/services/store_services.dart';
import 'package:goanmarketseller/views/product_screen/product_detials.dart';
import 'package:goanmarketseller/views/widgets/loading_indicator.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import '../controllers/productscontroller.dart';
import '../widgets/normal_text.dart';
import 'add_product.dart';

class productsScreen extends StatelessWidget {
  const productsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Productscontroller());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => Addproduct());
        },
        child: Icon(
          Icons.add,
        ),
      ),
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
        title: boldText(text: "Products", color: darkGrey, size: 16.0),
      ),
      body: StreamBuilder(
        stream: StoreServices.getproducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                        data.length,
                        (index) => ListTile(
                              onTap: () {
                                Get.to(() => ProductDetails(
                                      data: data[index],
                                    ));
                              },
                              leading: Image.network(
                                data[index]['p_img'][0],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              title: boldText(
                                  text: "${data[index]['p_name']}",
                                  color: fontGrey,
                                  size: 14.0),
                              subtitle: Row(
                                children: [
                                  normalText(
                                      text: "\$ ${data[index]['p_price']}",
                                      color: darkGrey),
                                  10.widthBox,
                                  boldText(
                                      text: data[index]['is_featured'] == true
                                          ? "featured"
                                          : '',
                                      color: green),
                                ],
                              ),
                              trailing: VxPopupMenu(
                                arrowSize: 0.0,
                                child: Icon(Icons.more_vert_rounded),
                                menuBuilder: () => Column(
                                  children: [
                                    ListView(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      children: List.generate(
                                        popupmenutitles.length,
                                        (i) => Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(children: [
                                            Icon(
                                              popupmenuIconslist[i],
                                              color: data[index]
                                                              ['featured_id'] ==
                                                          currentUser!.uid &&
                                                      i == 0
                                                  ? green
                                                  : darkGrey,
                                            ),
                                            10.widthBox,
                                            normalText(
                                                text:
                                                    data[index]['featured_id'] ==
                                                                currentUser!
                                                                    .uid &&
                                                            i == 0
                                                        ? "Removed featured"
                                                        : popupmenutitles[i],
                                                color: darkGrey),
                                          ]).onTap(() {
                                            switch (i) {
                                              case 0:
                                                if (data[index]
                                                        ['is_featured'] ==
                                                    true) {
                                                  controller.removeFeatured(
                                                       data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Removed");
                                                } else {
                                                  controller.addFeatured(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Added");
                                                }
                                                break;
                                              case 1:
                                                break;
                                              case 2:
                                                controller.removeProducts(data[index].id);
                                                VxToast.show(context, msg: "Product removed");
                                                break;
                                              default:
                                            }
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ).box.white.width(200).rounded.make(),
                                clickType: VxClickType.singleClick,
                              ),
                            )),
                  ),
                ]),
              ),
            );
          }
        },
      ),
    );
  }
}
