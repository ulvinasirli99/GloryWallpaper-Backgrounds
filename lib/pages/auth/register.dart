import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/animation/fade_animation.dart';
import 'package:wallpaper_app_flutter/pages/auth/login.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/wallpaper_page.dart';
import 'package:wallpaper_app_flutter/state/provider/authentication_provider.dart';

import 'package:wallpaper_app_flutter/validation/form_validate.dart';
import 'package:wallpaper_app_flutter/widget/global/toasts.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController reTypePasswordContrller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    reTypePasswordContrller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  height: MediaQuery.of(context).size.height - 50,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FadeAnimation(
                              1,
                              Text(
                                "Sign up",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                            1.2,
                            Text(
                              "Create an account, It's free",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          FadeAnimation(
                            1.2,
                            makeInput(
                              label: "Email",
                              controller: emailController,
                              authValidator: validateEmail,
                            ),
                          ),
                          FadeAnimation(
                            1.3,
                            makeInput(
                              label: "Password",
                              obscureText: true,
                              controller: passwordController,
                              authValidator: (val) {
                                if (val.isEmpty && val.length < 6) {
                                  return 'Pass is not empty';
                                }
                                return null;
                              },
                            ),
                          ),
                          FadeAnimation(
                            1.4,
                            makeInput(
                              label: "Confirm Password",
                              obscureText: true,
                              controller: reTypePasswordContrller,
                              authValidator: (reTpePass) {
                                if (reTypePasswordContrller.text !=
                                    passwordController.text) {
                                  print('object');
                                  return 'Passwords is not containes';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      FadeAnimation(
                          1.5,
                          Container(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              ),
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var regValue =
                                      authProvider.registerAuthProvider(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  regValue.whenComplete(() {
                                    setState(
                                      () {
                                        isLoading = false;
                                        error(
                                            'Registration was completed successfully.');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (ctx) => WallpaperPage(),
                                          ),
                                        );
                                      },
                                    );
                                  });
                                }
                              },
                              color: Colors.greenAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          )),
                      FadeAnimation(
                        1.6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already have an account?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                " Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: Lottie.asset(
                'assets/circle_loading_lottie.json',
                width: 70,
                height: 70,
              ),
            ),
    );
  }

  Widget makeInput({
    label,
    obscureText = false,
    required TextEditingController controller,
    required Function(String value) authValidator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          // obscureText: obscureText,
          controller: controller,
          validator: authValidator.call(""),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
