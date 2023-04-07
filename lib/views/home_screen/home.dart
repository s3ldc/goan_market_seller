import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/views/controllers/homeScreenController.dart';
import 'package:goanmarketseller/views/home_screen/home_screen.dart';
import 'package:goanmarketseller/views/order_screen/order_Screen.dart';
import 'package:goanmarketseller/views/profile_screen/profile_screen.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';

import '../product_screen/product_Screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const HomeScreen(),
      const productsScreen(),
      const orderScreen(),
      const ProfileScreen(),
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: dashboard,
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icproducts,
            color: purpleColor,
            width: 24,
          ),
          label: product),
      BottomNavigationBarItem(
          icon: Image.asset(
            icorders,
            color: purpleColor,
            width: 24,
          ),
          label: order),
      BottomNavigationBarItem(
          icon: Image.asset(
            icgeneral_setting,
            color: purpleColor,
            width: 24,
          ),
          label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
          () =>BottomNavigationBar(

        onTap: (index){
          controller.navIndex.value = index;
        },
            currentIndex: controller.navIndex.value,
        type: BottomNavigationBarType.fixed,
        // type: ,
        selectedItemColor: purpleColor,
        unselectedItemColor: darkGrey,
        items: bottomNavbar,
      ),),
      body: Column(
        children: [
          Obx(()=>
             Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
            ),
          )
        ],
      ),
    );
  }
}
