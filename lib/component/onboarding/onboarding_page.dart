import 'package:akilli_yurt/component/onboarding/rounded_button.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage(
      {Key? key,
        required this.image,
        required this.title,
        required this.description,
        required this.noOfScreen,
        required this.onNextPressed,
        required this.currentScreenNo})
      : super(key: key);

  final Image image;

  final String title;

  final String description;

  final int noOfScreen;

  final Function(int) onNextPressed;

  final int currentScreenNo;


  @override
  Widget build(BuildContext context) {
    bool isLastScreen = currentScreenNo >= noOfScreen - 1;
    return  Padding(
        padding: const EdgeInsets.all(10),
    child:Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image,
              const SizedBox(
                  height: 20,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 30, color:Colors.deepPurple.shade900),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: !isLastScreen,
          replacement: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width:300,
                  height: 50,
                  child: RoundedButton(
                      title: "Haydi Başlayalım",
                      onPressed: () {
                        openHomeScreen(context);
                      }, label: '',))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedButton(
                title: "Geç",
                onPressed:() {
                  openHomeScreen(context);
                }, label: '',
              ),

              Row(
                children: [
                  for(int index = 0; index <noOfScreen; index++ )
                    createProgressDots(
                        (index == currentScreenNo)? true : false)
                ],
              ),
              RoundedButton(
                title: "İleri",
                onPressed: () {
                  onNextPressed(currentScreenNo + 1);
                }, label: '',
              )],
          ),
        )
      ],
    ));
  }

  Widget createProgressDots(bool isActiveScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:8) ,
      height: isActiveScreen? 15: 10,
      width: isActiveScreen? 15: 10,
      decoration: BoxDecoration(
        color: isActiveScreen ? Colors.deepPurple : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
  void openHomeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }
}