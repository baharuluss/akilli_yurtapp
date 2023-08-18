import 'package:akilli_yurt/component/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  PageController controller = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xffd4c4e9),
      body: PageView(
        controller: controller ,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          OnboardingPage(
            image: Image.asset("assets/images/ogrenci.png"),
            title: "Akıllı Yurt Uygulamasına Hoşgeldin",
            description: "Merhaba, Bu Uygulama Gölhisar Kredi ve Yurtlar Kurumu'nda Konaklayan Öğrenciler İçin Tasarlanmıştır.",
            noOfScreen: 3,
            onNextPressed: changeScreen,
            currentScreenNo: 0,
          ),
          OnboardingPage(
            image: Image.asset("assets/images/randevu.png"),
            title: "Zamandan Tasarruf Et!",
            description: "Çamaşırhane'ye Gitmeden Çamaşır Makinesi Randevusu Alabilirsin.",
            noOfScreen: 3,
            onNextPressed: changeScreen,
            currentScreenNo: 1,
          ),
          OnboardingPage(
            image: Image.asset("assets/images/yemek.png"),
            title: "Pratik Yemek Listesi ",
            description: "Yemekhane Menüsü, Haftalık Düzenlenmiş Bir Şekilde Elinin Altında.",
            noOfScreen: 3,
            onNextPressed: changeScreen,
            currentScreenNo: 2,
          ),
        ],


      ),
    );
  }
  void changeScreen(int nextScreenNo) {
    controller.animateToPage(nextScreenNo,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

  }
}
