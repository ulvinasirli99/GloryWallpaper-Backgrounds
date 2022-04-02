import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  
  final FirebaseAuth firebaseAuth;

  AuthenticationService(this.firebaseAuth);

  Stream<User?> get authUserStateChnages => firebaseAuth.authStateChanges();

  // todo >>> Firebase Auth Login Service....<<<
  Future<String> signInWithEmail({String? email, String ?password}) async {
  
    try {
  
      await firebaseAuth.signInWithEmailAndPassword(
  
        email: email!,
  
        password: password!,
  
      );
  
      return 'Signed in is Successfully';
  
    } on FirebaseAuthException catch (e) {
  
      return e.message!;
  
  
    }  
  
  }

  // todo >>> Firebase Auth Rgister Service....<<<
  Future<String> signUpWithEmail({String? email, String ?password}) async {
  
    try {
  
      await firebaseAuth.createUserWithEmailAndPassword(
  
        email: email!,
  
        password: password!,
  
      );
  
      return 'User created is Successfully';
  
    } on FirebaseAuthException catch (e) {
  
      return e.message!;
  
    }
  
  }

  //todo >>> Firebase User signOut Service...<<<
  Future<void> userSignOut() async{
  
    await firebaseAuth.signOut();
  
  }

}

