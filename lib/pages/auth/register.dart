import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallpaper_app_flutter/components/extentions/loading_button.dart';
import 'package:wallpaper_app_flutter/pages/auth/login.dart';
import 'package:wallpaper_app_flutter/validation/form_validate.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController regEmailController = new TextEditingController();
  TextEditingController regPasswordController = new TextEditingController();
  bool isLoading = false;
  

  @override
  void dispose() {
    // TODO: implement dispose
    regEmailController.dispose();
    regPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            "assets/darwlogo.png",
                            width: 110,
                            height: 110,
                          ),
                        ),
                      ),
                      height: 150,
                    ),
                    Container(
                      height: 285,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(
                              2.0,
                              20.0,
                            ),
                            color: Colors.red.shade100.withOpacity(0.4),
                            blurRadius: 30.0,
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.05),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: regEmailController,
                              validator: (text) {
                                return validateEmail(text);
                              },
                              decoration: InputDecoration(
                                hintText: "Email",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.04),
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: regPasswordController,
                              validator: (text) {
                                return validatePassword(text);
                              },
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          Container(
                            width: size.width / 3,
                            height: 40,
                            child: Center(
                              child: LoadingButton(
                                isLoading: isLoading,
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Timer(Duration(seconds: 2), () {
                                      print(regEmailController.text);
                                    });
                                  }
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 45,
                            margin: EdgeInsets.only(
                              left: 40,
                              right: 40,
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => LoginScreen(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.indigo,
                                ),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.blue),
                              ),
                              icon: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Do you have an account?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
