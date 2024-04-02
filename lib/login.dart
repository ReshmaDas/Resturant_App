import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/homeScreen.dart';
import 'package:restaurant_app/modelClass/loginController.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height  = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 12,bottom: 12,right: 20,left: 20),
        child: Form(
          key: logincontroller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Text(
                    'Log in',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    child: TextFormField(
                      controller: logincontroller.emailController,
                      onSaved: (value) {
                        logincontroller.email = value!;
                      },
                      decoration: InputDecoration(
                        labelText: "username",
                        prefixIcon: Icon(
                          Icons.lock,
                          // size: size * .04,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 7, 12),
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        return logincontroller.validateEmail(value!);
                      },
                      keyboardType: TextInputType.name,
                      //style: TextStyle(fontSize: size * 0.04),
                    ),
                  ),
                ],
              ),
              SizedBox(height:20),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: TextFormField(
                  
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                         // size: size * .05,
                        ),
                        onPressed: () {}),
                    labelText: "password",
                    prefixIcon: Icon(
                      Icons.lock,
                      //size: size * .04,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 7, 12), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  //style: TextStyle(fontSize: size * 0.04),
                  controller: logincontroller.passwordController,
                  onSaved: (value) {
                    logincontroller.password = value!;
                  },
                  validator: (value) {
                    return logincontroller.validatePassword(value!);
                  },
                ),
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   SizedBox(
                     child: Row(
                       children: [
                         Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor:
                                          const Color.fromARGB(255, 87, 77, 145),
                                    ),
                                    child: Obx(
                                      () => Checkbox(
                                        value: logincontroller.value.value,
                                        onChanged: (newBool) {
                                          logincontroller
                                              .updateValue(newBool!);
                                        },
                                        activeColor:
                                            const Color.fromARGB(255, 87, 77, 145),
                                      ),
                                    ),
                                  ),
                                          Text(
                      "Remember me",
                      style: TextStyle(
                          color:  Colors.black,
                         // fontSize: size * .04,
                          fontWeight: FontWeight.bold),
                    ),
                       ],
                     ),
                   ),
                     
                  TextButton(
                    onPressed: () {
                      // Get.to(tmainscreen());
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          color:  Colors.green,
                         // fontSize: size * .04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                          height: 44,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                logincontroller.checkLogin();
                               
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (ctx) {
                                //       return Studentmainscreen();
                                //     },
                                //   ),
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                       Colors.orange),
                              child: const Text("Login",style: TextStyle(color: Colors.white))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
