import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopx/controllers/LoginController.dart';
import 'package:shopx/views/TourPage.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: emailController,
                obscureText: false,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: "Enter Your Email",
                    hintStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.lock)),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.remove_red_eye_outlined)),
              ),
              RaisedButton(onPressed: () {
                var email = emailController.text;
                var password = passwordController.text;
                loginController.fetchLoginData(email, password);
              }),
              Expanded(
                child: Obx(() {
                  if (loginController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (loginController.emails.value == null) {
                      return Container(
                        child: Text(loginController.msg.value),
                      );
                    } else {
                      return Container(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Text(loginController.emails.value),
                              Text(loginController.name.value),
                              Image.network(
                                  "https://tourguidebd.herokuapp.com/img/users/${loginController.photo.value}"),
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/get_tour_list");
                                  },
                                  child: Text("Go to Dashboard"),
                                  color: Colors.cyanAccent)
                            ],
                          ),
                        ),
                      );
                    }
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
