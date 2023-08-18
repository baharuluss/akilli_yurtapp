import 'package:flutter/material.dart';
import 'package:akilli_yurt/component/responsive/rounded_button_resp.dart';
import 'package:akilli_yurt/screens/home/home_screen.dart';
import 'package:akilli_yurt/screens/signin/signin_screen.dart';
import 'package:akilli_yurt/services/auth_response.dart';
import 'package:akilli_yurt/services/authentication_service.dart';
import 'package:akilli_yurt/utils/util.dart';
import 'package:flutter/services.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController pwdEditingController = TextEditingController();
  final TextEditingController cfrnPwdEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Kayıt Ol",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameEditingController,
                  keyboardType: TextInputType.name,
                  enableSuggestions: false,
                  autocorrect: false,
                  inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-ZğüşıöçĞÜŞİÖÇ ]')),
                ],
                  decoration: InputDecoration(
                      hintText: "İsim-Soyisim",
                      prefixIcon: const Icon(Icons.person),
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
                      return "İsim ve Soyiminizi giriniz.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
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
                  //Lets apply validation
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
                  //Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Şifrenizi giriniz.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cfrnPwdEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Şifrenizi tekrar giriniz",
                      prefixIcon: const Icon(Icons.key),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      fillColor: Colors.deepPurple[100]),
                  //Lets apply validation
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Şifrenizi tekrar giriniz";
                    } else if (value != pwdEditingController.text) {
                      return "Şifreniz eşleşmiyor";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RoundedButton(
                    label: "KAYIT OL",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {


                        AuthenticationService()
                            .signUpWithEmail(
                                name: nameEditingController.text,
                                email: emailEditingController.text,
                                password: pwdEditingController.text)
                            .then((authResponse) {
                          if (authResponse.authStatus == AuthStatus.success) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                                (route) => false);
                          } else {

                            Util.showErrorMessage(
                                context, authResponse.message);
                          }
                        });
                      }
                    })
              ],
            ),
          ),
          const SizedBox(
            height: 10,
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
                        color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }
}