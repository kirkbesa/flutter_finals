import 'package:flutter/material.dart';
import 'dart:async';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Navigate to the HomePage after 2 seconds, and remove the loading screen from the stack
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        '/login',
      ); // This removes the Loading screen from the stack
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Color customBlue = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: customBlue,
      body: FadeTransition(
        opacity: _opacity,
        child: const Center(
          child: Image(
            image: AssetImage('images/logo.png'),
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
