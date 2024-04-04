import 'dart:async';

import 'package:flutter/material.dart';
import 'package:random_quotes_generator/pages/homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (ctx)=> const HomePage(),
                ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff004AAD),
      body: SafeArea(
          child: Center(
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fill
                ),
              ),
            ),
          ),
      ),
    );
  }
}
