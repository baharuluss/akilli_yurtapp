import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:akilli_yurt/services/auth_response.dart';

class AuthenticationService {
  static const String emptyMsg = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future intializeService() async {

    if (kIsWeb) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyB8XXossyFVW2UC9E60Ea4QXxb4OUdIlWU",
              authDomain: "akilliyurtproject.firebaseapp.com",
              projectId: "akilliyurtproject",
              storageBucket: "akilliyurtproject.appspot.com",
              messagingSenderId: "135662367284",
              appId: "1:135662367284:web:283f25585829599eb85061",
              measurementId: "G-2N8HWLKQXX"));
    } else {
      await Firebase.initializeApp();
    }
  }

  Future<AuthResponse> signUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.updateDisplayName(name);
      return AuthResponse(AuthStatus.success, emptyMsg);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(AuthStatus.error, generateErrorMessage(e.code));
    }
  }


  Future<AuthResponse> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthResponse(AuthStatus.success, emptyMsg);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(AuthStatus.error, generateErrorMessage(e.code));
    }
  }


  Future<AuthResponse> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResponse(AuthStatus.success, emptyMsg);
    } on FirebaseAuthException catch (e) {
      return AuthResponse(AuthStatus.error, generateErrorMessage(e.code));
    }
  }


  Future signOut() async {
    await _auth.signOut();
  }

  String? getUserName() {
    return _auth.currentUser!.displayName;
  }

  String generateErrorMessage(errorCode) {
    String errorMessage;
    switch (errorCode) {
      case "invalid-email":
        errorMessage = "E-posta adresi hatalı gözüküyor";
        break;
      case "weak-password":
        errorMessage = "Şifre en az 6 karakter içermelidir";
        break;
      case "email-already-in-use":
        errorMessage = "E-posta adresi zaten başka bir hesap tarafından kullanılıyor";
        break;
      case "user-not-found":
        errorMessage = "Bu kimlik bilgilerine sahip kullanıcı mevcut değil";
        break;
      default:
        errorMessage = "Şifreyi yanlış girdiniz.";
    }
    return errorMessage;
  }
}