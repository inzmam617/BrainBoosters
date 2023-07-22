import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../AddNewFriend/AddFriend.dart';
import '../../ApiServices/ApiServiceToGetAllUsers.dart';
import '../../ChatScreen/ChatScreen.dart';
import '../../Models/FriendsListsModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../FriendRequestPage.dart';

class MainPeoplePage extends StatefulWidget {
  const MainPeoplePage({Key? key}) : super(key: key);
  @override
  State<MainPeoplePage> createState() => _MainPeoplePageState();
}

class _MainPeoplePageState extends State<MainPeoplePage> {
  List<Color> itemColors = [const Color(0xffEBECF9), const Color(0xffEEFAF6)];

  late IO.Socket socket;
  late String id;
  @override
  void initState(){
    super.initState();
    initialize();
    connectToServer();
  }

  void connectToServer() {
    try {
      print("starting");
      socket = IO.io('http://192.168.0.172:3000/',IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());
      socket.connect();
    } catch (e) {
      print(e.toString());
    }
  }
  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id =  prefs.getString("id").toString();
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
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
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
                width: MediaQuery.of(context).size.width / 1.7,
                child: SvgPicture.asset("assets/logo.svg",fit: BoxFit.cover,)),



            FutureBuilder<FriendsListsModel>(
              future: ApiServices.getUsersData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                else if (snapshot.hasData) { // Add this condition to check if data is available
                  final List<User> friendsList = snapshot.data?.friends ?? [];

                  if (friendsList.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 150.0, bottom: 150),
                      child: Center(child: Text('No friends found.')),
                    );
                  }
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          itemCount: friendsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Color itemColor = itemColors[index % itemColors.length];
                            final user = friendsList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
                                  borderRadius: BorderRadius.circular(30),
                                  color: itemColor,
                                ),
                                height: 80,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/profile.png"),
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(100)),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            user.name,
                                            style: TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                              user.email,
                                            style: TextStyle(color: Colors.black, fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              SizedBox(
                                                height: 28,
                                                width: 65,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty.all(
                                                      const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      ),
                                                    ),
                                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Map<String, String> message = {
                                                      'senderId': id,
                                                      'receiverId': user.id,
                                                      'roomId': id+user.id,
                                                    };
                                                    socket.emit("invite" ,message );
                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      "Invite",
                                                      style: TextStyle(color: Colors.red, fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              SizedBox(
                                                height: 28,
                                                width: 65,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty.all(
                                                      const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      ),
                                                    ),
                                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Get.to(() =>  ChatScreen(myUserId: id, otherUserId: user.id, name: user.name,));
                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      "Chat",
                                                      style: TextStyle(color: Colors.green, fontSize: 10),
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
                  // If data is null or empty, show a message or return an empty widget.
                  return const Center(child: Text('No data available.'));
                }
              },
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
