import 'package:flutter/material.dart';
import 'package:flutter_finals/login.dart';
import 'loading.dart';
import 'mpin.dart';
import 'home.dart';
import 'inbox.dart';
import 'qr.dart';
import 'transactions.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color customBlue = Color(0xFF0380FF);

    return MaterialApp(
      title: 'Basic Flutter App',
      theme: ThemeData(
        primaryColor: customBlue,
        scaffoldBackgroundColor: customBlue.withOpacity(0.1),
        primarySwatch: MaterialColor(customBlue.value, {
          50: customBlue.withOpacity(0.1),
          100: customBlue.withOpacity(0.2),
          200: customBlue.withOpacity(0.3),
          300: customBlue.withOpacity(0.4),
          400: customBlue.withOpacity(0.5),
          500: customBlue.withOpacity(0.6),
          600: customBlue.withOpacity(0.7),
          700: customBlue.withOpacity(0.8),
          800: customBlue.withOpacity(0.9),
          900: customBlue,
        }),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Loading(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        '/inbox': (context) => const Inbox(),
        '/qr': (context) => const QRPage(),
        '/transactions': (context) => const Transactions(),
        '/profile': (context) => const Profile(),
        '/mpin': (context) => const MPINScreen(),
      },
    );
  }
}
