import 'package:flutter/material.dart';
import 'package:akilli_yurt/component/responsive/rounded_button_resp.dart';
import 'package:akilli_yurt/screens/signin/signin_screen.dart';
import 'package:akilli_yurt/screens/signup/signup_screen.dart';

class LoginRegisterButtons extends StatelessWidget {
  const LoginRegisterButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Gölhisar Akıllı Yurt Uygulaması",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),

          const SizedBox(
            height: 20,
          ),

          
          RoundedButton(
              label: "GİRİŞ YAP",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                        (route) => false);
              }),

          const SizedBox(
            height: 10,
          ),

          RoundedButton(
              label: "KAYIT OL",
              onPressed: () {
                
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                        (route) => false); 
              }),
        ],
      ),
    );
  }
}