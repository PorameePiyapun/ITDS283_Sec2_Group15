import 'package:flutter/material.dart';
import '/screens/login/login_1.dart';
import '/screens/login/signup.dart';
import '/screens/login/login_2.dart';
import '/screens/login/login_3.dart';
import 'package:help_you_to_mu_health/screens/browse.dart' as browse; // Alias for BrowseScreen
import 'package:help_you_to_mu_health/screens/reservationScreen.dart' as reservation; // Alias for ReservationScreen
import 'screens/setting/account.dart';
import 'screens/setting/contactus.dart';
import 'screens/setting/language.dart';
import 'screens/setting/noti.dart';
import 'screens/setting/privacy.dart';
import 'screens/setting/setting.dart';


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

        '/account': (context) =>  AccountPage(),
        '/contactus': (context) => ContactUsPage(),
        '/language': (context) =>  LanguagePage(),
        '/noti': (context) =>  NotificationPage(),
        '/privacy': (context) =>  PrivacyPage(),
        '/setting': (context) =>  SettingsPage(),
        
        '/browse': (context) => browse.BrowseScreen(), // Use alias for BrowseScreen
        '/reservation': (context) => reservation.ReservationScreen(), // Use alias for ReservationScreen
      },
    );
  }
}
