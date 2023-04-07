import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/views/controllers/productscontroller.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';

Widget productDropdown(hint, List<String> list, dropvalue, Productscontroller controller) {
  return Obx(()=>
     DropdownButtonHideUnderline(
      child: DropdownButton(
        value: dropvalue.value == "" ? null : dropvalue.value,
        hint: normalText(text: "$hint", color: fontGrey),
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(value: e, child: e.toString().text.make());
        }).toList(), // convert Iterable to List
        onChanged: (newvalue) {
          if(hint == "Category"){
            controller.subcategoryvalue.value= '';
            controller.populateSubCategoryList(newvalue.toString());
          }
          dropvalue.value= newvalue.toString();
        },
      ),
    ).box.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.white.make(),
  );
}
