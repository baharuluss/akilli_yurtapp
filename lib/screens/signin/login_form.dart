import 'package:flutter/material.dart';
import 'package:akilli_yurt/component/responsive/rounded_button_resp.dart';
import 'package:akilli_yurt/screens/forgotpassword/forgot_password_screen.dart';
import 'package:akilli_yurt/screens/home/home_screen.dart';
import 'package:akilli_yurt/screens/signup/signup_screen.dart';
import 'package:akilli_yurt/services/auth_response.dart';
import 'package:akilli_yurt/services/authentication_service.dart';
import 'package:akilli_yurt/utils/util.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController pwdEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            "Giriş Yap",
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
                      fillColor: Colors.deepPurple[100]),
                  
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
                TextFormField(
                  controller: pwdEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Şifre",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.deepPurple[100]),
                  
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Şifrenizi giriniz";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ForgotPasswordScreen()),
                                (route) => false);
                      },
                      child: const Text("Şifrenizi unuttunuz mu?"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                    label: "GİRİŞ YAP",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                        AuthenticationService()
                            .signInWithEmail(
                            email: emailEditingController.text,
                            password: pwdEditingController.text)
                            .then((authResponse) {
                          if (authResponse.authStatus == AuthStatus.success) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  const HomeScreen()),
                                    (route) => false);
                          } else {
                            Util.showErrorMessage(
                                context, authResponse.message);
                          }
                        });
                      }
                    })
              ])),
          const SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Hesabın yok mu? "),
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
        ],
      ),
    );
  }
}