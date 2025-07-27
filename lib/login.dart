import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF1f71fa), // Blue background color
        child: Column(
          children: [
            // Top Part
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.fromLTRB(0, 200, 0, 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo, Good day, Number
                    Column(
                      children: [
                        // Logo
                        Image(
                          image: AssetImage('images/logo_horizontal_white.png'),
                          width: 400,
                          height: 100,
                        ),
                        // Good Day!
                        Text(
                          'Good Day!',
                          style: TextStyle(
                            fontFamily: 'Poppins', // Poppins SemiBold font
                            fontWeight: FontWeight.w600, // SemiBold weight
                            color: Colors.white, // White text color
                            fontSize: 20,
                          ),
                        ),
                        // Number
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          width: 250,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xFF1168f1),
                            border: Border.all(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '092738039355',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                const Icon(
                                  Icons
                                      .swap_horiz_rounded, // Using the built-in 'keyboard' icon (you can change this to another icon)
                                  size: 30, // Icon size
                                  color: Colors.blue, // Icon color
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // MPIN Login
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      width: 170,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons
                                  .dialpad_sharp, // Using the built-in 'keyboard' icon (you can change this to another icon)
                              size: 60, // Icon size
                              color: Colors.blue, // Icon color
                            ),
                            const SizedBox(
                              height: 20,
                            ), // Space between icon and text
                            Text(
                              'MPIN Login',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Part
            Container(
              height: 100, // Fixed height
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white38, // Border color
                    width: 1.0, // Border width
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the row content
                children: [
                  // "Help Center" text
                  Text(
                    'Help Center',
                    style: TextStyle(
                      fontFamily: 'Poppins', // Poppins SemiBold font
                      fontWeight: FontWeight.w600, // SemiBold weight
                      color: Colors.white, // White text color
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ), // Add space between the two text elements
                  // "Forgot MPIN?" text
                  Text(
                    'Forgot MPIN?',
                    style: TextStyle(
                      fontFamily: 'Poppins', // Poppins SemiBold font
                      fontWeight: FontWeight.w600, // SemiBold weight
                      color: Colors.white, // White text color
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
