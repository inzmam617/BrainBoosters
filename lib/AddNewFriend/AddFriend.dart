import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({Key? key}) : super(key: key);
  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}
class _AddFriendScreenState extends State<AddFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 35,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 3.5)
                      ],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color(0xff494FC7)),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: SizedBox(
                              width: 30,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      360)))),
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.white)),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Text(
                            "Add Friend",
                            style: TextStyle(
                                color: Colors.white, fontSize: 17),
                          )
                        ],
                      ),

                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset("assets/logo.svg",fit: BoxFit.scaleDown,),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 3.5)
                ]),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: TextFormField(
                decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 15,),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: "Find Friends",
                    // contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(itemBuilder: (BuildContext context, int index) {
              return  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  height: 65,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/profile.png")),
                              borderRadius: BorderRadius.all(Radius.circular(100))),
                        ),
                        const SizedBox(width: 10,),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("John Smith" ,style: TextStyle(color: Colors.black,fontSize: 13),),
                            SizedBox(height: 5,),
                            Text("8/10 - 251",style: TextStyle(color: Colors.black,fontSize: 11)),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 30,
                          width: 100,
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
                                Get.defaultDialog(
                                  title:
                                    "Add a friend",
                                  middleText: "",
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all(
                                                  const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                ),
                                                backgroundColor: MaterialStateProperty.all(const Color(0xff494FC7)),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                                Get.showSnackbar(
                                                  const GetSnackBar(
                                                    message: 'Request Sent Successfully',
                                                    // icon: const Icon(Icons.refresh),
                                                    duration: Duration(seconds: 3),
                                                  ),
                                                );
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: Center(
                                                  child: Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
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
                                                Get.back();

                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: Center(
                                                  child: Text(
                                                    "Back  ",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                  backgroundColor: Colors.white,
                                  titleStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,),
                                  radius: 30,
                                );
                              },
                              child: const Center(
                                child: Text("Add Friend" ,style: TextStyle(color: Colors.blue,fontSize: 12),),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },),
          ),
          )
        ],
      ),
    );
  }
}
