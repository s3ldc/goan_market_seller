import 'package:get/get.dart';
import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/views/controllers/profile_controller.dart';
import 'package:goanmarketseller/views/widgets/custom_textfield.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/normal_text.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: "Shop Settings", size: 16.0),
          actions: [
            controller.isLoading.value? LoadingIndicator(circle_Color: white)
            : TextButton(
                onPressed: () async {
                  controller.isLoading(true);
                  await controller.updateShop(
                          shopwebsite: controller.shopAddressController.text,
                          shopmobile: controller.shopMobileController.text,
                          shopaddress: controller.  shopAddressController.text,
                          shopname: controller.shopNameController.text,
                          shopdesc: controller.shopDescriptionController.text);
                  VxToast.show(context, msg: "Shop Updated");
                },
                child: normalText(text: "Save", color: white))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              10.heightBox,
              CustomeTextField(
                  label: "Shop Name",
                  hint: "Enter shop name",
                  controller: controller.shopNameController),
              10.heightBox,
              CustomeTextField(
                  label: "Shop Address",
                  hint: "Enter shop address",
                  controller: controller.shopAddressController),
              10.heightBox,
              CustomeTextField(
                  label: "Shop Mobile",
                  hint: "Enter shop mobile number",
                  controller: controller.shopMobileController),
              10.heightBox,
              CustomeTextField(
                  label: "Shop Website",
                  hint: "Enter shop website",
                  controller: controller.shopWebsiteController),
              10.heightBox,
              CustomeTextField(
                  label: "Description",
                  hint: 'Enter shop description',
                  isDesc: true,
                  controller: controller.shopDescriptionController),
            ],
          ),
        ),
      ),
    );
  }
}
