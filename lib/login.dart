import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF1f71fa), // Blue background color
        child: Column(
          children: [
            // Top Part
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo, Good day, Number
                    Column(
                      children: [
                        // Logo
                        const Image(
                          image: AssetImage('images/logo_horizontal_white.png'),
                          width: 400,
                          height: 100,
                        ),
                        // Good Day!
                        const Text(
                          'Good Day!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // Number
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          width: 250,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1168f1),
                            border: Border.all(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                Icon(
                                  Icons.swap_horiz_rounded,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // MPIN Login - Now Clickable
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/mpin');
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        width: 170,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.dialpad_sharp,
                                size: 60,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 20),
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
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Part
            Container(
              height: 100,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white38,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Help Center',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 60),
                  Text(
                    'Forgot MPIN?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
