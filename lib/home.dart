import 'package:flutter/material.dart';
import 'components/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavBar and Box Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Content area (will take the remaining space)
          Expanded(
            child: Container(
              color: Colors.white, // Light grey background for content
              child: const Center(
                child: Text(
                  'Content goes here',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),

          // Bottom Navbar with 5 icons
          const BottomNavBar(currentRoute: '/home'),
        ],
      ),
    );
  }
}
