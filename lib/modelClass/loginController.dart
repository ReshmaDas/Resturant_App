import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/homeScreen.dart';
import 'package:restaurant_app/login.dart';
import 'package:restaurant_app/modelClass/shared_pre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
    TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


   
final GlobalKey<FormState> formKey = GlobalKey<FormState>();






   @override
  void onReady() {
    checkLoginStatus();
    super.onReady();
  }
  var email = "";
  var password = "";

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Enter valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 charecters";
    }
    return null;
  }

  RxBool value = false.obs;
  void updateValue(bool newValue) {
    value.value = newValue;
  }
 

 RxBool loading = false.obs;


   void checkLogin() {
    final isValid = formKey.currentState!.validate();
    {
      if (!isValid) {
        return;
      }
       formKey.currentState!.save();
      loading.value = true;
      Get.showOverlay(
          asyncFunction: () => login(),
          loadingWidget: const CircularProgressIndicator());
    }
  }


 Future<void> login() async {
  final isValid = formKey.currentState!.validate();
  if (!isValid) {
    return;
  }

  formKey.currentState!.save();

  final email = emailController.text.trim();
  final passWord = passwordController.text.trim();

  if (email.isEmpty || passWord.isEmpty) {
    // Handle empty fields
    return;
  }

  try {
  
    await SharedPrefrence().setLoggedIn(true);
    
    await SharedPrefrence().setUserEmail(email);
   
    await SharedPrefrence().setUserPassWord(passWord);

     
    final storedEmail = await SharedPrefrence().getUserEmail();
    print('Stored User Email: $storedEmail');
     Get.to(HomePage());
     emailController.clear();
     passwordController.clear();
  } catch (e) {
    // Handle error
    print('Error: $e');
    return;
  }


}




void checkLoginStatus() async {
  final isLoggedIn = await SharedPrefrence().getLogedIn();
  if (isLoggedIn) {
    Get.offAll(HomePage());
    
  } else {
    Get.offAll(LoginPage());
    
  }
}






}