import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'account-state.dart';

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

    Color customBlue = Theme.of(context).primaryColor;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: customBlue, // Blue background color
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
                        image: AssetImage('assets/images/logo_horizontal_white.png'),
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
                          color: customBlue,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
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
                                color: Colors.white.withValues(alpha: 0.8),
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
                          return MPINLoginDrawer(
                            scaffoldContext: context,
                            scaffoldKey: scaffoldKey,
                          );
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
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.dialpad_sharp,
                              size: 60,
                              color: customBlue,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'MPIN Login',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: customBlue,
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
  final BuildContext scaffoldContext;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const MPINLoginDrawer({super.key, required this.scaffoldContext, required this.scaffoldKey});

  @override
  _MPINLoginDrawerState createState() => _MPINLoginDrawerState();
}

class _MPINLoginDrawerState extends State<MPINLoginDrawer> {
  List<String> pin = [];
  final String phoneNumber = '092738039355';

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

  Future<void> _checkPin() async {
    if (pin.length == 4) {
      final accountState = context.read<AccountState>();
      
      try {
        print('Attempting login with PIN: ${pin.join()}');
        final success = await accountState.login(phoneNumber, pin.join());
        
        // Check if widget is still mounted before accessing context
        if (!mounted) return;
        
        print('Login result: $success, Error: ${accountState.error}');
        
        if (success) {
          // Navigate to the home page if login is successful
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Show error message using the correct context
          print('Showing error snackbar: ${accountState.error ?? 'Login failed'}');
          // Close the modal first, then show snackbar
          Navigator.pop(context);
          Future.delayed(const Duration(milliseconds: 100), () {
            ScaffoldMessenger.of(widget.scaffoldContext).showSnackBar(
              SnackBar(
                content: Text(accountState.error ?? 'Login failed'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          });
          // Reset Pin
          setState(() {
            pin.clear();
          });
        }
      } catch (e) {
        // Check if widget is still mounted before accessing context
        if (!mounted) return;
        
        print('Login exception: $e');
        // Close the modal first, then show snackbar
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 100), () {
          ScaffoldMessenger.of(widget.scaffoldContext).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        });
        setState(() {
          pin.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color customBlue = Theme.of(context).primaryColor;
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
                          ? customBlue
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
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
                        color: customBlue,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _removeDigit();
                    },
                    child: Icon(Icons.backspace, size: 20, color: customBlue),
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
