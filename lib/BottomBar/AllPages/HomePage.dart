import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),

          content: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ),

                SizedBox(height: 20,),
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
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return ChooseYourStudyForQuiz();
                      }));
                    },
                  ),
                ),
                SizedBox(height: 20,),

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
                            MaterialStateProperty.all(Color(0xffC94905))),
                    child: const Text(
                      'Invite a Friend',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();

                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return ChooseYourStudyForQuiz();
                      }));
                    },
                  ),
                ),
                SizedBox(height: 20,),

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
                            MaterialStateProperty.all(Color(0xff138F60))),
                    child: const Text(
                      'Matchmaking',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();

                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return ChooseYourStudyForQuiz();
                      }));                    },
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
            height: 35,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
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
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset("assets/logo.svg"),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 3.5)
                    ]),
                height: 40,
                width: MediaQuery.sizeOf(context).width * 0.7,
                child: Center(
                  child: TextFormField(
                    decoration: const InputDecoration(
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
                width: 20,
              ),
              SizedBox(
                  height: 38,
                  width: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                      },
                      child: const Center(
                          child: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ))))
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    height: 80,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFBED21))),
                        onPressed: () {
                          _showAlertDialog();

                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Geography VG1 & Science",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "12 Chapters",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "Price:12kr",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffFBED21), width: 5),
                      image: const DecorationImage(
                          image: AssetImage("assets/one.jpg")),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  height: 80,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    height: 80,
                    width: MediaQuery.sizeOf(context).width * 0.6,
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Religion and Philosophy",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "12 Chapters",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "Price:23kr",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ))),
                const SizedBox(
                  width: 10,
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
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    height: 80,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffEB4A2A))),
                        onPressed: () {
                          _showAlertDialog();

                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "History And Economics",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "12 Chapters",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "Price:52kr",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffEB4A2A), width: 5),
                      image: const DecorationImage(
                          image: AssetImage("assets/three.jpg")),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  height: 80,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                    height: 80,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffC3D7A2))),
                        onPressed: () {
                          _showAlertDialog();

                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Religion and Philosophy",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "12 Chapters",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "Price:12kr",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffC3D7A2), width: 5),
                      image: const DecorationImage(
                          image: AssetImage("assets/four.jpg")),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100))),
                  height: 80,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),

          // Expanded(
          //   child: ListView.builder(
          //     physics: ScrollPhysics(),
          //     shrinkWrap: true,
          //     itemCount: _items.length,
          //     itemBuilder: (context, index) {
          //       final item = _items[index];
          //       var isSelected = _selectedItems.contains(item);
          //       return Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //         child: Row(
          //           children: [
          //             SizedBox(
          //                 height: 80,
          //                 width: MediaQuery.sizeOf(context).width * 0.6,
          //                 child: ElevatedButton(
          //                     style: ButtonStyle(
          //                         shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          //                             borderRadius: BorderRadius.all(Radius.circular(20)))),
          //                         backgroundColor:
          //                         MaterialStateProperty.all(const Color(0xffFBED21))),
          //                     onPressed: (){
          //
          //                     }, child: const Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text("Geography VG1",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),),
          //                     Text("12 Chapters",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),),
          //                     Text("Price:12kr",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),),
          //                   ],
          //                 ))),
          //             SizedBox(
          //               width: 10,
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                   border:
          //                       Border.all(color: Color(0xffFBED21), width: 5),
          //                   image: DecorationImage(
          //                       image: AssetImage("assets/gs.jpg")),
          //                   borderRadius:
          //                       BorderRadius.all(Radius.circular(100))),
          //               height: 80,
          //               width:  MediaQuery.sizeOf(context).width * 0.3 - 20,
          //             )
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),

          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
