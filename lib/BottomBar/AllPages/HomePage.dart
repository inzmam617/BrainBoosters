import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../BottomNavBar.dart';
import 'ChooseYourStudyforQuize.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          // <-- SEE HERE
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),

          content: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 30,
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        backgroundColor: MaterialStateProperty.all(
                            const Color(0xff494FC7))),
                    child: const Text('Play Solo'),
                    onPressed: () {
                      Get.to(() => const BottomNavBar(page: 2));
                    },

                  ),
                ),
                const SizedBox(height: 20,),

                SizedBox(
                  height: 30,
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffC94905))),
                    child: const Text(
                      'Invite a Friend',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.back();
                      // Get.to(() => const BottomNavBar(page: 1,));
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return const BottomNavBar(page: 1,);
                      }));
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 30,
                  width: 180,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff138F60))),
                    child: const Text(
                      'Matchmaking',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.to(() =>  const ChooseYourStudyForQuiz());
                      },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
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
                    "Recently Played",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
                  hintStyle: TextStyle(fontSize: 16,),

                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: "Find and replay chapters",
                    // contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFDF8A6))),
                        onPressed: () {
                          _showAlertDialog();

                        },
                        child:  Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Geography VG1 & Science",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "12 Chapters",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "Price:12kr",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ))),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffFDF8A6), width: 5),
                      image: const DecorationImage(
                          image: AssetImage("assets/one.jpg")),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.2,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffF4F4FB))),
                        onPressed: () {                        _showAlertDialog();


                        },
                        child:  Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Religion and Philosophy",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "12 Chapters",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "Price:23kr",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ))),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffF4F4FB), width: 5),
                      image: const DecorationImage(
                          image: AssetImage("assets/two.jpg")),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.2,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffF6B6A9))),
                        onPressed: () {
                          _showAlertDialog();

                        },
                        child:  Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "History And Economics",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "12 Chapters",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "Price:52kr",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ))),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffF6B6A9), width: 5),
                      image: const DecorationImage(
                          image: AssetImage("assets/three.jpg")),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.2,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffE6EED9))),
                        onPressed: () {
                          _showAlertDialog();

                        },
                        child:  Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Religion and Philosophy",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "12 Chapters",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "Price:12kr",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ))),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffE6EED9), width: 5),
                      image: const DecorationImage(
                          image: AssetImage("assets/four.jpg")),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.2,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }
}
