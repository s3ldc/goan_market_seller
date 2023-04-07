import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:goanmarketseller/const/const.dart';

class AuthController extends GetxController {


  // FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();



//login
  Future<UserCredential?> loginMethod({context}) async{
    UserCredential? userCredential;

    try {
userCredential =
      await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e){
      VxToast.show(context, msg:e.toString());
    }
    return userCredential;
  }

  //signOut
  signoutMethod(context) async{
    try {
      await auth.signOut();
    }catch (e){
      VxToast.show(context, msg:e.toString());
    }
  }
}