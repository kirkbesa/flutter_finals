import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MPIN Login with Drawer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Login(),
    );
  }
}

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      // Open the bottom drawer when tapped
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return MPINLoginDrawer();
                        },
                      );
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

            // Bottom Part
            Container(
              height: 100,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white38, width: 1.0),
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

class MPINLoginDrawer extends StatefulWidget {
  const MPINLoginDrawer({super.key});

  @override
  _MPINLoginDrawerState createState() => _MPINLoginDrawerState();
}

class _MPINLoginDrawerState extends State<MPINLoginDrawer> {
  List<String> pin = [];
  final String correctPin = '1234'; // Default correct pin

  void _addDigit(String digit) {
    if (pin.length < 4) {
      setState(() {
        pin.add(digit);
      });
    }
  }

  void _removeDigit() {
    if (pin.isNotEmpty) {
      setState(() {
        pin.removeLast();
      });
    }
  }

  void _checkPin() {
    if (pin.join() == correctPin) {
      // Navigate to the home page if the pin is correct
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Reset Pin
      pin.clear();
      // Show modal if the pin is incorrect
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incorrect MPIN'),
            content: const Text('Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Try Again'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the bottom sheet when tapping outside
        Navigator.pop(context);
      },
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.only(top: 100, bottom: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 50,
            children: [
              // Pin indicator (4 circles)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      backgroundColor: index < pin.length
                          ? Colors.blue
                          : Colors.blueGrey,
                      radius: 6,
                    ),
                  );
                }),
              ),
              // Keypad
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      _addDigit('1');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addDigit('2');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addDigit('3');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '3',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      _addDigit('4');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '4',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addDigit('5');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '5',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addDigit('6');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '6',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      _addDigit('7');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '7',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addDigit('8');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '8',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addDigit('9');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '9',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      _addDigit('');
                    },
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _addDigit('0');
                      if (pin.length == 4) {
                        _checkPin();
                      }
                    },
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _removeDigit();
                    },
                    child: Icon(Icons.backspace, size: 20, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
