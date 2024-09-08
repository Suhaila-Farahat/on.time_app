import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:to_to_app/Constants.dart';
import 'package:to_to_app/Views/Home%20view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeView()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      body:Center(
        child: SizedBox(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 50,
              fontFamily: defaultFont
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                    'on.time',
                  speed: Duration(milliseconds: 100),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ),
        ),
      )

    );
  }
}
