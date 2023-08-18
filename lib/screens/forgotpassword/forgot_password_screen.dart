import 'package:flutter/material.dart';
import 'package:akilli_yurt/component/responsive/mobile_layout.dart';
import 'package:akilli_yurt/component/responsive/responsive_layout.dart';
import 'package:akilli_yurt/component/responsive/web_layout.dart';
import 'package:akilli_yurt/screens/forgotpassword/forgot_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        webChild: WebLayout(
          imageWidget: Image.asset(
            "assets/images/forgot.jpg",
            width: 150,
          ),
          dataWidget:
              ForgotPasswordForm(), 
        ),
        mobileChild: MobileLayout(
          imageWidget: Image.asset(
            "assets/images/forgot.jpg",
            width: 75,
          ),
          dataWidget: ForgotPasswordForm(),
        ));
  }
}