import 'package:akilli_yurt/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:akilli_yurt/screens/welcome/welcome_screen.dart';
import 'package:akilli_yurt/services/authentication_service.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthenticationService.intializeService();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        secondaryHeaderColor: Colors.deepPurple,
        primarySwatch:Colors.indigo,
      ),
      routes: {
        "/": (context) => OnboardingScreen(),
        "/home": (context) => const WelcomeScreen()
      },
    );
  }
}

