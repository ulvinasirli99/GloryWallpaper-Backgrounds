import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallpaper_app_flutter/service/http/auth/auth_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  final authService = AuthenticationService(FirebaseAuth.instance);

  bool? _isLogged;

  AuthenticationProvider() {
    _isLogged = false;
  }

  bool? get isLogged => _isLogged;

  set isLoggedIn(bool isLog) {
 
    _isLogged = isLog;
 
    notifyListeners();
 
  }

  Future registerAuthProvider({String? email, String? password}) async {
 
    isLoggedIn = true;
 
    await authService.signUpWithEmail(
 
      email: email!,
 
      password: password!,
 
    );
 
    isLoggedIn = false;
 
  }

  Future<UserCredential?> loginAuthProvider({String? email, String? password}) async {
 
    isLoggedIn = true;
 
    await authService.signInWithEmail(email: email!, password: password!);
 
    isLoggedIn = false;
 
  }

  Future logoutAccountProvider() async {
 
    isLoggedIn = true;
 
    await authService.userSignOut();
 
     isLoggedIn = false;
 
  }

}

