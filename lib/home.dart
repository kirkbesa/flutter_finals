import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Karla Regular',
              style: TextStyle(
                fontFamily: 'Karla',
                fontWeight: FontWeight.normal, // Regular
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Karla Light',
              style: TextStyle(
                fontFamily: 'Karla',
                fontWeight: FontWeight.w300, // Light
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Karla SemiBold',
              style: TextStyle(
                fontFamily: 'Karla',
                fontWeight: FontWeight.w600, // SemiBold
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Karla Bold',
              style: TextStyle(
                fontFamily: 'Karla',
                fontWeight: FontWeight.bold, // Bold
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Poppins Regular',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal, // Regular
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Poppins Light',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300, // Light
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Poppins SemiBold',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600, // SemiBold
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Poppins Bold',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold, // Bold
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
