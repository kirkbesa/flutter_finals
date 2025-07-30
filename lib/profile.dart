import 'package:flutter/material.dart';
import 'components/bottom_navbar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const BottomNavBar(currentRoute: '/profile'),
        ],
      ),
    );
  }
}
