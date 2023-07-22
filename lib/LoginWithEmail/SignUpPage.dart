import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ApiServices/ApiServiceforSignupUser.dart';
import 'LoginPage.dart';

class SignUpEmailPassword extends StatefulWidget {
  const SignUpEmailPassword({super.key});

  @override
  State<SignUpEmailPassword> createState() => _SignUpEmailPasswordState();
}

class _SignUpEmailPasswordState extends State<SignUpEmailPassword> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const SizedBox(height: 100,),
                SizedBox(
                    height: 35,
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: SvgPicture.asset("assets/logo.svg",fit: BoxFit.cover,)),

                SizedBox(height: MediaQuery.of(context).size.height / 8,),
                const Text(
                  "SignUp With Email And Password",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.5
                        )
                      ]
                  ),
                  child: TextFormField(
                    controller: name,

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),

                        hintText: "Enter you name"
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.5
                        )
                      ]
                  ),
                  child: TextFormField(
                    controller: email,

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),

                        hintText: "Enter your email"
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.5
                        )
                      ]
                  ),
                  child: TextFormField(
                    controller: pass,

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),

                        hintText: "Enter your password"
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)))),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.grey)),
                    onPressed: () {

                      if(email.text== "" && pass.text == "" && name.text== ""){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Fields cannot be empty'),
                        ));
                      }
                      else{

                        ApiServicesforSignUp.signup(email.text, pass.text , name.text).then((value) {
                          if(value.message == "Student created successfully"){
                            ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                              content: Text('Student created successfully'),
                            ));
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                              return LoginEmailPassword();
                            }));
                          }
                          else{
                            print("Failed");
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Warning!'),
                                content:  Text(value.message.toString() ?? value.error.toString()),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        });

                      }

                    },
                    child: const Text("Create User" ,style: TextStyle(color: Colors.white,fontSize: 16),),
                  ),
                ),
                SizedBox(height: 30,),
                TextButton(onPressed: (){
                  Get.back();

                }, child: Text("Already have an Account? try SignIn",style: TextStyle(color: Colors.black),))
              ],
            ),
          ),
        )

    );
  }
}
