import 'dart:convert';

import 'package:brainboosters/BottomBar/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../AddNewFriend/AddFriend.dart';
import '../../ApiServices/ApiForGettingQuizes.dart';
import '../../ApiServices/ApiServiceToGetAllUsers.dart';
import '../../ChatScreen/ChatScreen.dart';
import '../../Models/CoursesModels.dart';
import '../../Models/FriendsListsModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../QuizePage/QuizePage.dart';
import '../../const.dart';
import '../FriendRequestPage.dart';

class MainPeoplePage extends StatefulWidget {
  final List<SubCourse>?  subcourses;
  final String? courseName;
  const MainPeoplePage({Key? key, this.subcourses, this.courseName}) : super(key: key);
  @override
  State<MainPeoplePage> createState() => _MainPeoplePageState();
}

class _MainPeoplePageState extends State<MainPeoplePage> {
  List<Color> itemColors = [const Color(0xffEBECF9), const Color(0xffEEFAF6)];

  late IO.Socket socket;
  late String id;

  @override
  void initState() {
    super.initState();
    initialize();
    initilize();
    connectToServer();
    initilize();

  }



  void connectToServer() {
    try {
      print("starting");
      socket = IO.io(baseUrl, IO.OptionBuilder().setTransports(['websocket'])
          .disableAutoConnect()
          .build());
      socket.connect();
    } catch (e) {
      print(e.toString());
    }
  }

  String? chapterName = "Nothing";
  String? subCourseName = "Nothing";
  String? courseName  = "Nothing";
  Future<void> initilize() async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    setState(() {
      chapterName =  prefs.getString("ChapterName");
      subCourseName =  prefs.getString("subCourseName");
      courseName =  prefs.getString("courseName");
    });
  }

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString("id").toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
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
                          "My Main People",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const RequestPage();
                      }));
                }, child: const Text("See Request")),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: 35,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.7,
                child: SvgPicture.asset("assets/logo.svg", fit: BoxFit.cover,)),
            FutureBuilder<FriendsListsModel>(
              future: ApiServicesforGetFriendsandNonFriends.getUsersData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                else if (snapshot
                    .hasData) { // Add this condition to check if data is available
                  final List<User> friendsList = snapshot.data?.friends ?? [];
                  if (friendsList.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 150.0, bottom: 150),
                      child: Center(child: Text('No friends found.')),
                    );
                  }
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 2,
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: friendsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Color itemColor = itemColors[index %
                                itemColors.length];
                            final user = friendsList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  color: itemColor,
                                ),
                                height: 80,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/profile.png"),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.35,

                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text(
                                                  user.name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  user.email,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .end,
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [

                                              SizedBox(
                                                height: 28,
                                                width: 60,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                10)),
                                                      ),
                                                    ),
                                                    backgroundColor: MaterialStateProperty
                                                        .all(Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    if(chapterName == "null"){
                                                      print("object");
                                                      _ShowMessage();
                                                    }else {
                                                      Map<String,String> quizData = {
                                                      "courseName": courseName.toString(),
                                                      "subcourseName": subCourseName.toString(),
                                                      "chapterName": chapterName.toString()
                                                    };
                                                    Map<String,dynamic> message = {
                                                      'senderId': id,
                                                      'receiverId': user.id,
                                                      'roomId': id + user.id,
                                                      "quizData" : quizData,
                                                    };
                                                    print(message);
                                                    socket.emit("invite", message);
                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                      content: Text('Invitation Sent Successful'),
                                                    ));

                                                    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                                    //   return BottomNavBar(page: 0,);
                                                    // }));
                                                    }

                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      "Invite",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              SizedBox(
                                                height: 28,
                                                width: 60,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                10)),
                                                      ),
                                                    ),
                                                    backgroundColor: MaterialStateProperty
                                                        .all(Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Get.to(() => ChatScreen(
                                                      myUserId: id,
                                                      otherUserId: user.id,
                                                      name: user.name,));
                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      "Chat",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                  ;
                } else {
                  return const Center(child: Text('No data available.'));
                }
              },
            ),
            const SizedBox(height: 10,),
            SizedBox(
                height: 35,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)))),
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xff494FC7))),
                    onPressed: () {

                     print ( "chapterName:"   );



                     if(chapterName == "null"){
                       print("object");
                       _ShowMessage();
                     }
                     else {
                       print("object");

                       Navigator.of(context).push(
                           MaterialPageRoute(builder: (BuildContext context) {
                             return QuizPage(
                                 courseName: courseName,
                                 subcourseName: subCourseName,
                                 chapterName: chapterName,
                                 Id: id,
                                 MatchType: "solo"

                             );
                           }));
                     }

                    },
                    child: const Text(
                      "Play Solo",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ))), const SizedBox(height: 10,),

            SizedBox(
                height: 35,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)))),
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xffC94905))),
                    onPressed: () {
                      Get.to(() => const AddFriendScreen());
                    },
                    child: const Text(
                      "Add A Friend",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ))), const SizedBox(height: 10,),

            SizedBox(
                height: 35,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)))),
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xff138F60))),
                    onPressed: () {
                      _showMyDialog();
                    },
                    child: const Text(
                      "Matchmaking",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ))),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        // Show the dialog
        AlertDialog dialog = AlertDialog(
          title: const Text('Invite has been sent'),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Waiting for 30 people to join'),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );

        // Automatically close the dialog after 10 seconds
        Future.delayed(const Duration(seconds: 10), () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Room could not be filed'),
          ));
        });

        return dialog;
      },
    );
  }
  Future<void> _ShowMessage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please Select a Chapter from Home screen before'),
                Text('Starting a Quiz!'),
              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}