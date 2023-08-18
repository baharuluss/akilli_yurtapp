import 'package:flutter/material.dart';
import 'package:akilli_yurt/component/responsive/mobile_layout.dart';
import 'package:akilli_yurt/component/responsive/responsive_layout.dart';
import 'package:akilli_yurt/component/responsive//web_layout.dart';
import 'package:akilli_yurt/screens/welcome/login_register_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        webChild: WebLayout(
          imageWidget: Image.asset(
            "assets/images/welcome.jpg",
            width: 250,
            height: 250,
          ),
          dataWidget:
              const LoginRegisterButtons(),
        ),
        mobileChild: MobileLayout(
          imageWidget: Image.asset(
            "assets/images/welcome.jpg",
            height: 150,
          ),
          dataWidget: const LoginRegisterButtons(),
        ));
  }
}