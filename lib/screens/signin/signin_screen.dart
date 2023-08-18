import 'package:flutter/material.dart';
import 'package:akilli_yurt/component/responsive/responsive_layout.dart';
import 'package:akilli_yurt/component/responsive/mobile_layout.dart';
import 'package:akilli_yurt/component/responsive/web_layout.dart';
import 'package:akilli_yurt/screens/signin/login_form.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        webChild: WebLayout(
          imageWidget: Image.asset(
            "assets/images/login.jpg",
            width: 150,
          ),
          dataWidget:
              LoginForm(), 
        ),
        mobileChild: MobileLayout(
          imageWidget: Image.asset(
            "assets/images/login.jpg",
            width: 75,
          ),
          dataWidget: LoginForm(),
        ));
  }
}
