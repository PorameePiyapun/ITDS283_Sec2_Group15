import 'package:flutter/material.dart';
import '/screens/login/login_1.dart';
import '/screens/login/signup.dart';
import '/screens/login/login_2.dart';
import '/screens/login/login_3.dart';
import '/screens/browse.dart' as browse; // Alias for BrowseScreen
import 'screens/setting/account.dart' as account;
import 'screens/setting/contactus.dart' as contactus;
import 'screens/setting/language.dart' as language;
import 'screens/setting/noti.dart' as noti;
import 'screens/setting/privacy.dart';
import 'screens/setting/setting.dart';
import 'screens/homescreen.dart';
import 'screens/medicationsscreen.dart';


void main() {
  runApp(const HelpYouToMUHealthApp());
}

class HelpYouToMUHealthApp extends StatelessWidget {
  const HelpYouToMUHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help You to MU Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login1Screen(),
        '/signup': (context) => SignUpScreen(),
        '/login_2': (context) => const Login2Screen(),
        '/login_3': (context) => const Login3Screen(),
        '/account': (context) =>  account.AccountPage(),
        '/contactus': (context) => contactus.ContactUsPage(),
        '/language': (context) =>  language.LanguagePage(),
        '/notification': (context) =>  noti.NotificationPage(),
        '/privacy': (context) =>  PrivacyPage(),
        '/setting': (context) =>  SettingsPage(),
        '/browse': (context) => browse.BrowseScreen(),
        '/home': (context) =>  HomeScreen(),
        '/medication': (context) =>  MedicationsScreen()
      },
    );
  }
}
