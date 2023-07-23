import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../BottomBar/BottomNavBar.dart';
import '../LoginScreens/LoginPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  String id = "";

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() async {
      id =  prefs.getString("id") ??  "";
    });
    print(id);
  }
  @override
  void initState() {
    super.initState();
    initialize();

    Timer(
        const Duration(seconds: 4),
            () =>
                Get.to(() => id == "" ?  const LoginScreen() : BottomNavBar(page: 0, ))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff494FC7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome to BrainBoosters!',
                  textStyle: const TextStyle(color: Colors.white,fontSize: 40),textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 100),
                ),
              ],

              // totalRepeatCount: 4,
              // pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: false,
              stopPauseOnTap: false,
            ),
          ),



        ],
      ),
    );
  }
}
