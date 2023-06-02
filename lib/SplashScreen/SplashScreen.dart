import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../LoginScreens/LoginPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff494FC7),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Transform.translate(
                    offset: Offset(-120, -180),
                    child: SvgPicture.asset("assets/ring.svg")),
                Transform.translate(
                    offset: Offset(-120, -120),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(360)),
                          color: Colors.white12),
                    )),
              ],
            ),
          ),
          // const Center(child: Text("Welcome to BrainBoosters",style: TextStyle(color: Colors.white,fontSize: 40),textAlign: TextAlign.center,),),

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
          )


        ],
      ),
    );
  }
}
