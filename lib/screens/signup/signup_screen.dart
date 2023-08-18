import 'package:flutter/material.dart';
import 'package:akilli_yurt/component/responsive/mobile_layout.dart';
import 'package:akilli_yurt/component/responsive/responsive_layout.dart';
import 'package:akilli_yurt/component/responsive/web_layout.dart';
import 'package:akilli_yurt/screens/signup/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        webChild: WebLayout(
          imageWidget: Image.asset(
            "assets/images/signup.png",
            width: 150,
          ),

          dataWidget:
              SignUpForm(),
        ),
        mobileChild: MobileLayout(
          imageWidget: Image.asset(
            "assets/images/signup.png",
            width: 75,
          ),
          dataWidget: SignUpForm(),
        ));
  }
}

