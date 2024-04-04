import 'dart:async';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 79, 79, 1),
      body: SafeArea(
        child: Center(
          child:
              //     Container(
              //   width: 200,
              //   height: 200,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/auy.jpeg'), // Path to your image
              //       fit: BoxFit.cover, // Adjust this according to your needs
              //     ),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              // )

              CircleAvatar(
            backgroundImage: AssetImage('assets/images/auy.jpeg'),
            radius: 100,
          ),
        ),
      ),
    );
  }
}
//0xfff2f2f2
//Color.fromRGBO(47, 79, 79, 1),
