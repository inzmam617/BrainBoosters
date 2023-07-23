import 'package:brainboosters/FeedbackPage/FeedbackPage.dart';
import 'package:brainboosters/LoginScreens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiServices/ApiServieForSignInOut.dart';
import '../../ChooseCourseStudy/ChooseCourse.dart';
import '../BottomNavBar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
    initialize();
  }
  String? name;
  String? email;
  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name").toString();
      email = prefs.getString("email").toString();
    });
  }

  List<IconData> icons = [
    Icons.music_note,
    Icons.color_lens_outlined,
    // Icons.phone_android,
    // Icons.notifications,
    Icons.book_outlined,
    Icons.star,
    Icons.share,
    Icons.person
  ];
  List text = [
    "Music",
    "Toggle the colorblind tool",
    // "Toggle Shakes in the phone",
    // "Toggle Push Notification",
    "Change Course of Study",
    "Send Feedback",
    "Share App",
    "Log Out"
  ];
  List<Function> onPressedFunctions = [];
  List<ValueNotifier<bool>> boolean = [
    ValueNotifier<bool>(true),
    ValueNotifier<bool>(true),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
    ValueNotifier<bool>(false),
  ];

  @override
  Widget build(BuildContext context) {
    onPressedFunctions = [
      () {
        print("object");
        // Get.to(() => BottomNavBar(
        //       page: 1,
        //     ));

        // Function 1
        // Add your code here
      },
      () {
        // Function 2
        // Add your code here
      },
      //     () {
      //   // Function 3
      //   // Add your code here
      // },
      //     () {
      //   // Function 4
      //   // Add your code here
      // },
      () {
        Get.to(() => const ChooseCoursePage());
        // Function 5
        // Add your code here
      },
      () {
        Get.to(() => const FeedBackScreen());
        // Function6 6
        // Add your code here
      },
      () {
        // Function 7
        // Add your code here
      },
      () {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Icon(Icons.person, color: Colors.black),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Are you sure you want to Logout?'),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 28,
                      width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff494FC7)),
                        ),
                        child: const Text('Confirm'),
                        onPressed: () {
                          ApiServicesforSignIn_Out.logOut().then((value) async {
                            if (value.message ==
                                "Student logged out successfully") {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              prefs.remove("id");
                              prefs.remove("name");
                              prefs.remove("email");
                              prefs.remove("chapterName");
                              prefs.remove("courseName");
                              prefs.remove("chapterId");

                              Get.to(() => const LoginScreen());
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(value.message.toString()),
                              ));
                            } else {
                              print("Failed");
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Warning!'),
                                  content: Text(value.message.toString() ??
                                      value.error.toString()),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 28,
                      width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }
    ];
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 55,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 35,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 3.5)
                      ],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color(0xff494FC7)),
                  child: const Center(
                      child: Text(
                    "Settings",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset("assets/logo.svg"),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Name: ${name ?? ""}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold ,  fontSize: 14),),
                Text("Email:  ${email ?? ""}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold ,  fontSize: 14)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                bool isTrue = index < 2;

                return button(icons[index], text[index],
                    onPressedFunctions[index], isTrue, boolean[index]);
              },
            ),
          )
        ],
      ),
    );
  }
  Widget button(
      icons, text, onpressed, check, ValueNotifier<bool> checkBoxBool) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          onPressed: onpressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        icons,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        text,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  check == true
                      ? ValueListenableBuilder<bool>(
                          valueListenable: checkBoxBool,
                          builder: (context, value, child) {
                            return Switch(
                              activeTrackColor: Colors.grey,
                              inactiveTrackColor: Colors.grey,
                              activeColor: const Color(0xff494FC7),
                              value: value,
                              onChanged: (bool newValue) {
                                checkBoxBool.value = newValue;
                              },
                            );
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
