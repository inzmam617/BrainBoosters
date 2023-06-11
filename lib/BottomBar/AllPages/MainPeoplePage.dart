import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../AddNewFriend/AddFriend.dart';
import '../../ChatScreen/ChatScreen.dart';

class MainPeoplePage extends StatefulWidget {
  const MainPeoplePage({Key? key}) : super(key: key);
  @override
  State<MainPeoplePage> createState() => _MainPeoplePageState();
}

class _MainPeoplePageState extends State<MainPeoplePage> {
  List<Color> itemColors = [const Color(0xffEBECF9), const Color(0xffEEFAF6)];
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
                    width: MediaQuery.of(context).size.width * 0.4,
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
                SvgPicture.asset("assets/logo.svg",fit: BoxFit.scaleDown,),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),


            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                final Color itemColor = itemColors[index % itemColors.length];
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
                      borderRadius: BorderRadius.circular(30),
                      color: itemColor,
                    ),
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/profile.png")),
                                borderRadius: BorderRadius.all(Radius.circular(100))),
                          ),
                          const SizedBox(width: 10,),
                           Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("John Smith" ,style: TextStyle(color: Colors.black,fontSize: 14),),
                              SizedBox(height: 5,),
                              Text("8/10 - 251",style: TextStyle(color: Colors.black,fontSize: 11)),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Active",style: TextStyle(color: Colors.black,fontSize: 12)),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      width: 60,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                          onPressed: () {
                                          },
                                          child: const Center(
                                            child: Text("Invite" ,style: TextStyle(color: Colors.red,fontSize: 10),),
                                          )),
                                    ),
                                    const SizedBox(width: 10,),
                                    SizedBox(
                                      height: 25,
                                      width: 60,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                              backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                          onPressed: () {
                                            Get.to(()=> ChatScreen(myUserId: '1', otherUserId: '2', name: 'asd',));
                                          },
                                          child: const Center(
                                            child: Text("Chat" ,style: TextStyle(color: Colors.green,fontSize: 10),),

                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );

              },),
            ),
            const SizedBox(height: 10,),

            SizedBox(
                height: 35,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)))),
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xff494FC7))),
                    onPressed: () {},
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
                width: MediaQuery.of(context).size.width * 0.5,
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
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)))),
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xff138F60))),
                    onPressed: () {},
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
}
