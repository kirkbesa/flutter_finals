import 'package:flutter/material.dart';

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
              color: Colors.grey[200], // Light grey background for content
              child: const Center(
                child: Text(
                  'Content goes here',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),

          // Bottom Navbar with 5 icons
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100, // Height of the navbar
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_outlined, color: Colors.blue, size: 30),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mail_outline_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                        Text(
                          'Inbox',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          'QR',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, color: Colors.blue, size: 30),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // QR Icon with circle and outline using Container only
              Positioned(
                bottom: 50,
                left: MediaQuery.of(context).size.width / 2 - 40,
                child: Container(
                  width: 80, // Total width (radius * 2)
                  height: 80, // Total height (radius * 2)
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Background color
                    border: Border.all(
                      color: Colors.blue, // Outline color
                      width: 3.0, // Outline width
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: Colors.blue,
                      size: 30,
                    ),
                    onPressed: () {
                      print('QR Icon clicked');
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
