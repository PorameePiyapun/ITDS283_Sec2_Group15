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
import 'package:help_you_to_mu_health/screens/reservationScreen.dart';
import 'screens/bmi_screen.dart';

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
        primaryColor: Colors.white, // Set accent color
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // AppBar background color
          foregroundColor: Colors.black, // AppBar text/icon color
          elevation: 0, // Remove shadow
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Default text color
          bodyMedium: TextStyle(color: Colors.black54), // Secondary text color
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF3cc4b4), // Button background color
          textTheme: ButtonTextTheme.primary, // Button text color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Color(0xFF3cc4b4), // Elevated button text color
          ),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF3cc4b4)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login1Screen(),
        '/signup': (context) => SignUpScreen(),
        '/login_2': (context) => const Login2Screen(),
        '/login_3': (context) => const Login3Screen(),
        '/account': (context) => account.AccountPage(),
        '/contactus': (context) => contactus.ContactUsPage(),
        '/language': (context) => language.LanguagePage(),
        '/notification': (context) => noti.NotificationPage(),
        '/privacy': (context) => PrivacyPage(),
        '/setting': (context) => SettingsPage(),
        '/browse': (context) => browse.BrowseScreen(),
        '/home': (context) => HomeScreen(),
        '/medication': (context) => MedicationsScreen(),
        '/reservation': (context) => const ReservationScreen(),
        '/bmi': (context) => BMIScreen(),
      },
    );
  }
}