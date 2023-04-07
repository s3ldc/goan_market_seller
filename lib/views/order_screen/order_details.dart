import 'package:get/get.dart';
import 'package:goanmarketseller/views/controllers/orders_controller.dart';
import 'package:goanmarketseller/views/order_screen/components/order_place.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import '../widgets/our_button.dart';
import '../widgets/normal_text.dart';

class Orderdetails extends StatefulWidget {
  final dynamic data;
  const Orderdetails({Key? key, this.data}) : super(key: key);

  @override
  State<Orderdetails> createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  var controller = Get.find<ordercontroller>();

  @override
  void initState() {
    super.initState();
    controller.getOrder(widget.data);
    controller.confirmed.value  = widget.data['order_confirmed '];
    controller.ondelivery.value  = widget.data['order_on_delivery '];
    controller.delivered.value  = widget.data['order_delivered '];
    // controller.confirmed.value  = widget.data['order_confirmed '];

  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: fontGrey),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.white,
          actions: [
            10.widthBox,
          ],
          title: boldText(text: "Order Details", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              color: green,
              onPress: () {
                controller.confirmed(true);
                controller.changeStatus(
                    title: 'order_confirmed',
                    status: true,
                    docId: widget.data.id);
              },
              title: "Confirm Order",
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //order detivery status section
                    Visibility(
                        visible: controller.confirmed.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(
                                text: "Order status:",
                                color: purpleColor,
                                size: 16.0),
                            SwitchListTile(
                              activeColor: Colors.green,
                              value: controller.confirmed.value,
                              onChanged: (value) {
                                controller.confirmed.value = value;
                              },
                              title: boldText(text: "Placed", color: fontGrey),
                            ),
                            SwitchListTile(
                              activeColor: Colors.green,
                              value: controller.ondelivery.value,
                              onChanged: (value) {
                                controller.ondelivery.value = value;

                                controller.changeStatus(
                                    title: 'order_on_delivery',
                                    status: value,
                                    docId: widget.data.id);
                              },
                              title:
                                  boldText(text: "Confirmed", color: fontGrey),
                            ),
                            SwitchListTile(
                              activeColor: Colors.green,
                              value: controller.delivered.value,
                              onChanged: (value) {
                                controller.delivered.value = value;
                                controller.changeStatus(title: 'order_delivered',status : value  ,docId: widget.data.id );
                              },
                              title: boldText(
                                  text: "on Delivery ", color: fontGrey),
                            ),
                          ],
                        )
                            .box
                            .padding(const EdgeInsets.all(8))
                            .outerShadowMd
                            .white
                            .border(color: lightGrey)
                            .roundedSM
                            .make()),

                    //order details section
                    orderPlaceDetials(
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "order code",
                        title2: "shipping method"),
                    orderPlaceDetials(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((widget.data['order_date'])),
                        d2: "${widget.data['payment_method']}",
                        title1: "Order date",
                        title2: "Payment method"),
                    orderPlaceDetials(
                        d1: "Unpaid",
                        d2: "order_placed ",
                        title1: "paymentstatus",
                        title2: "deliverystatus"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Shipping Address", color: purpleColor),
                              "${widget.data['orderbyname']}".text.make(),
                              "${widget.data['orderbyemail']}".text.make(),
                              "${widget.data['orderbyaddress']}".text.make(),
                              "${widget.data['orderbycity']}".text.make(),
                              "${widget.data['orderbystate']}".text.make(),
                              "${widget.data['orderbyphhone']}".text.make(),
                              "${widget.data['orderbypostalcode']}".text.make(),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total Amount ", color: purpleColor),
                                boldText(
                                    text: "${widget.data['total_amount']}",
                                    color: red),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
              ),
            ),
            const Divider(),
            10.heightBox,
            boldText(text: "Ordered Products", color: fontGrey, size: 16.0),
            10.heightBox,
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(controller.orders.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetials(
                        title1: "${controller.orders[index]['title']}",
                        title2: "${controller.orders[index]['tprice']}",
                        d1: "${controller.orders[index]['qty']}x}",
                        d2: "Refundable"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: 30,
                        height: 20,
                        color: Color(controller.orders[index]['color']),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            )
                .box
                .outerShadowMd
                .white
                .margin(const EdgeInsets.only(bottom: 4))
                .make(),
            20.heightBox
          ]),
        ),
      ),
    );
  }
}
