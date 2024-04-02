import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class SharedPrefrence {


  // final logincontroller1 = LoginController();

  Future<bool> setLoggedIn(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("logged_in", status);
  }

  Future<bool> getLogedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("logged_in") ?? false;
  }

  Future<bool> setUserEmail(String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(userEmail);
    print(userEmail);
    return prefs.setString("email", userEmail);
  }

  Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("email") ?? '';
  }


  Future<bool> setUserPassWord(String userPs) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(userPs);
    print(userPs);
    return prefs.setString("ps", userPs);
  }

  Future<String> getUserPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("ps") ?? '';
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("logged_in");
    await prefs.remove("email");
    await prefs.remove("ps");
    print('Logged out successfully');
     Get.to(LoginPage());
  }
}