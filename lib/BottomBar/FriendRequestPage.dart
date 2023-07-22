import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ApiServices/ApiServiceForHandlingReq.dart';
import '../ApiServices/ApiServiceForRequestsLists.dart';
import '../Models/FriendReqModel.dart';


class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final StreamController<List<FriendRequest>> _friendRequestsController =
  StreamController<List<FriendRequest>>();

  @override
  void initState() {
    super.initState();
    _loadFriendRequests();
  }

  @override
  void dispose() {
    _friendRequestsController.close();
    super.dispose();
  }

  Future<void> _loadFriendRequests() async {
    try {
      final friendRequests = await ApiServicesforReq.getAllFriendRequests();
      _friendRequestsController.add(friendRequests);
    } catch (e) {
      print('Failed to load friend requests: $e');
      _friendRequestsController.addError('Failed to load friend requests');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
          height: 60,
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
                        "My Requests",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              const SizedBox(
                width: 20,
              ),


            ],
          ),
          StreamBuilder<List<FriendRequest>>(
            stream: _friendRequestsController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final friendRequests = snapshot.data!;
                if (friendRequests.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Center(
                      child: Text('No friend requests found.'),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: friendRequests.length,
                        itemBuilder: (BuildContext context, int index) {
                          final friendRequest = friendRequests[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blueGrey,
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
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            friendRequest.name,
                                            style: const TextStyle(color: Colors.black, fontSize: 14),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            friendRequest.id,
                                            style: const TextStyle(color: Colors.black, fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 24,
                                                width: 70,
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
                                                    ApiServiceForHandlingRequests.acceptUser(friendRequest.id).then((value) =>
                                                    {
                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    content: Text('Request Accepted!'),
                                                    )),
                                                      Get.back()

                                                    });
                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      "Accept",
                                                      style: TextStyle(color: Colors.red, fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                height: 25,
                                                width: 70,
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
                                                    ApiServiceForHandlingRequests.declineUser(friendRequest.id).then((value) =>
                                                    {
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                        content: Text('Request Rejected!'),
                                                      )),
                                                      Get.back()
                                                    });
                                                  },
                                                  child: const Center(
                                                    child: Text(
                                                      "Reject",
                                                      style: TextStyle(color: Colors.green, fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
                  );
                  //   Expanded(
                  //   child: ListView.builder(
                  //     itemCount: friendRequests.length,
                  //     itemBuilder: (context, index) {
                  //       final friendRequest = friendRequests[index];
                  //       // Build UI for each friend request here...
                  //       return ListTile(
                  //         title: Text(friendRequest.name),
                  //         // Add more information or buttons as needed...
                  //       );
                  //     },
                  //   ),
                  // );
                }
              } else {
                return Center(
                  child: Text('No data available.'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
