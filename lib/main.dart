import 'package:el_bershama/features/auth/login/login.dart';
import 'package:el_bershama/features/auth/signUp/sign_up.dart';
import 'package:el_bershama/features/home/home_screen.dart';
import 'package:el_bershama/features/newMdeicien/add_medic.dart';
import 'package:el_bershama/features/splash/splash.dart';
import 'package:el_bershama/features/Onboarding/Onboarding_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ar', 'EG'),
      home: Splash(),
      routes: {
        'start' :(context)=>OnboardingScreen(),
        'login' :(context)=>Login(),
        'singUp' :(context)=>SignUp(),
        'Home' :(context)=>HomeScreen(),
        'addMedicine': (context) => const AddMedicineScreen(),
      },
    );
  }
}
