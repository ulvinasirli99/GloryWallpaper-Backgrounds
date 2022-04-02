// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/animation/fade_animation.dart';
import 'package:wallpaper_app_flutter/pages/auth/register.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/wallpaper_page.dart';
import 'package:wallpaper_app_flutter/state/provider/authentication_provider.dart';
import 'package:wallpaper_app_flutter/validation/form_validate.dart';
import 'package:wallpaper_app_flutter/widget/global/toasts.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              FadeAnimation(
                                  1,
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  1.2,
                                  Text(
                                    "Login to your account",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey[700]),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
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
                                      if (val!.isEmpty && val.length < 6) {
                                        return 'Pass is not empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FadeAnimation(
                              1.4,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  padding: EdgeInsets.only(top: 3, left: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                        top: BorderSide(color: Colors.black),
                                        left: BorderSide(color: Colors.black),
                                        right: BorderSide(color: Colors.black),
                                      )),
                                  child: MaterialButton(
                                    minWidth: double.infinity,
                                    height: 60,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        try {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          UserCredential userCredential =
                                              await FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                          );
                                          if (userCredential.user != null) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            error('The entry was successful');
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    WallpaperPage(),
                                              ),
                                            );
                                          }
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            error(
                                                'Such a user does not exist.');
                                          } else if (e.code ==
                                              'wrong-password') {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            error(
                                                'Your password is incorrect.');
                                          }
                                        }
                                      }
                                    },
                                    color: Colors.greenAccent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          FadeAnimation(
                            1.5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Don't have an account?"),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeAnimation(
                      1.2,
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/background.png'),
                                fit: BoxFit.cover)),
                      ),
                    )
                  ],
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

  Widget makeInput(
      {label,
      obscureText = false,
      required TextEditingController controller,
      required Function(String? value)? authValidator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          // obscureText: obscureText,
          controller: controller,
          validator: authValidator?.call(""),
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
            )),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
