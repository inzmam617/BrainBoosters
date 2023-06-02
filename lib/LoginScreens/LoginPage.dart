import 'package:brainboosters/ChooseCourseStudy/ChooseCourse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 4,),
            const Text(
              "Login",
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff494FC7))),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return ChooseCoursePage();
                  }));
                },
                child: Row(
                  children: [
                    SvgPicture.asset("assets/facebook-round-icon.svg"),
                    const SizedBox(width: 20,),
                    const Text("Login with Facebook" ,style: TextStyle(color: Colors.white,fontSize: 16),),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.white)),
                onPressed: () {},
                child: Row(
                  children: [
                    SvgPicture.asset("assets/google.svg"),
                    const SizedBox(width: 20,),
                    const Text("Login with Google" ,style: TextStyle(color: Colors.black,fontSize: 16),),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.black)),
                onPressed: () {},
                child: Row(
                  children: [
                    SvgPicture.asset("assets/apple.svg"),
                    const SizedBox(width: 20,),
                    const Text("Login with Apple" ,style: TextStyle(color: Colors.white,fontSize: 16),),
                  ],
                ),
              ),
            ),

            // SizedBox(
            //   height: 40,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Divider(thickness: 1.5,),
            // ),
            // SizedBox(
            //   height: 50,
            // ),
            // Text("OR",style: TextStyle(color: Colors.black,fontSize: 15),),





          ],
        ),
      ),
    );
  }
}
