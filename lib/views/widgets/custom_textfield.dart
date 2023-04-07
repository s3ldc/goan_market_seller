import 'package:goanmarketseller/const/const.dart';
import 'package:goanmarketseller/views/widgets/normal_text.dart';

Widget CustomeTextField({label, hint, controller,isDesc = false}) {
  return TextFormField(
    style: const TextStyle(color: Colors.white),
    controller: controller,
    maxLines: isDesc ? 4:1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label,),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white)),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGrey)

    ),
  );
}
