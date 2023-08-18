import 'package:flutter/material.dart';
import 'package:akilli_yurt/component/responsive/rounded_button_resp.dart';
import 'package:akilli_yurt/screens/signin/signin_screen.dart';
import 'package:akilli_yurt/screens/signup/signup_screen.dart';
import 'package:akilli_yurt/services/auth_response.dart';
import 'package:akilli_yurt/services/authentication_service.dart';
import 'package:akilli_yurt/utils/util.dart';

class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        const Text(
          "Şifreni Sıfırla",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: emailEditingController,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    hintText: "E-posta",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    fillColor: Colors.grey[300]),
                
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "E-posta adresinizi giriniz";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              RoundedButton(
                  label: "ŞİFREYİ SIFIRLA",
                  onPressed: () {
                    
                    AuthenticationService()
                        .resetPassword(email: emailEditingController.text)
                        .then((authResponse) {
                      if (authResponse.authStatus == AuthStatus.success) {
                        Util.showSuccessMessage(context,
                            "Şifrenizi sıfırlamak için mail gönderildi, lütfen E-posta adresinizi kontrol edin.");
                      } else {
                        Util.showErrorMessage(context, authResponse.message);
                      }
                    });
                  })
            ])),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Zaten bir hesabınız var mı? "),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                    (route) => false);
              },
              child: const Text("Giriş Yap",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Hesabınız yok mu? "),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                    (route) => false);
              },
              child: const Text("Kayıt Ol",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold)),
            )
          ],
        )
      ]),
    );
  }
}