import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiServices/ApiServiceForUserInfo.dart';
import '../ApiServices/ApiServieForSignInOut.dart';
import '../ChooseCourseStudy/ChooseCourse.dart';
import 'SignUpPage.dart';

class LoginEmailPassword extends StatefulWidget {
  const LoginEmailPassword({super.key});

  @override
  State<LoginEmailPassword> createState() => _LoginEmailPasswordState();
}

class _LoginEmailPasswordState extends State<LoginEmailPassword> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
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
                  "Login With Email And Password",
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
                  child: Center(
                    child: TextFormField(

                      controller: email,

                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: InputBorder.none,

                          hintText: "Enter your name"
                      ),
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
                  child: Center(
                    child: TextFormField(
                      controller: pass,

                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),

                          border: InputBorder.none,
                          hintText: "Enter your password"
                      ),
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
                        MaterialStateProperty.all(Colors.orangeAccent)),
                    onPressed: (){
                      if(email.text == "" && pass.text == ""){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Fields cannot be empty'),
                        ));
                      }

                      else {
                        setState(() {
                          _loading = true;
                        });
                        ApiServicesforSignIn_Out.signIn(email.text, pass.text ).then((value) async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                        if(value.message == null){
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                            content: Text('Student Login successfully'),
                          ));
                          ApiServicetoGetUserInfo.GetPersionalInfo(value.id!).then((values) => {
                           prefs.setString("name", values.name!),
                           prefs.setString("email", values.email!),


                        });
                          print("This is the id: ${value.id}");

                          prefs.setString("id", value.id.toString());
                          String id = prefs.getString("id").toString();
                          print("this is my id: $id");
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return const ChooseCoursePage();
                          }));
                          setState(() {
                            _loading = false;
                          });
                        }
                        else{
                          setState(() {
                            _loading = false;
                          });
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
                    child: const Text("Login" ,style: TextStyle(color: Colors.white,fontSize: 16),),
                  ),
                ),
                SizedBox(height: 30,),
                TextButton(onPressed: (){
                        Get.to(()  =>const SignUpEmailPassword());
                }, child: Text("Doesn't have an Account? try SignUp",style: TextStyle(color: Colors.black),))
              ],
            ),
          ),
        )

      ),
    );
  }
}
