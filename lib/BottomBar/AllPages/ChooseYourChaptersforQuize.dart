import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/CoursesModels.dart';
import '../../Models/SampleSubCourseForChaptersNew.dart';
import '../BottomNavBar.dart';

class ChooseYourChaptersForQuiz extends StatefulWidget {
  final List<SubCourse>?  subcourses;
  final String?  subcourseName;
  const ChooseYourChaptersForQuiz({Key? key, this.subcourses, this.subcourseName}) : super(key: key);

  @override
  State<ChooseYourChaptersForQuiz> createState() =>
      _ChooseYourChaptersForQuizState();
}

class _ChooseYourChaptersForQuizState extends State<ChooseYourChaptersForQuiz> {

  List pictures = [
    "assets/ce.jpg",
    "assets/gs.jpg",
    "assets/ce.jpg",
    "assets/h.jpg"

  ];
  setChapters( String chapterId,  String chapterName,  String courseName ) async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();
    prefs.setString("chapterName",chapterName );
    prefs.setString("chapterId",chapterId );
    prefs.setString("courseName",courseName);
    Get.to(() =>  BottomNavBar(page: 0));
  }
  List <SubCourse>  chapters = [

  ];

  @override
  void initState(){
    super.initState();
    setState(() {
      chapters.addAll(widget.subcourses!);

       });


  }


  Future<void> _show3list(List<Chapter> chapters) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: 150,
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                return ListTile(
                  onTap: (){
                    print(chapter.name);
                    // Navigator.of(context).pop();
                    // _showAlertDialog();
                  },
                  title: Text(chapter.name),
                );
              },
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
          Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
                color: Color(0xff494FC7),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(150))),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Center(
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: SizedBox(
                                    width: 35,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)))),
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
                                const Text(
                                  "Choose your Chapters",
                                  style: TextStyle(
                                      color: Color(0xff494FC7), fontSize: 17),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "    Define your future",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                              width: 150,
                              child: Divider(
                                color: Colors.white,
                                thickness: 1.5,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Transform.translate(
                          offset: const Offset(25, 0),
                          child: SvgPicture.asset(
                            "assets/chapter.svg",
                            fit: BoxFit.cover,
                          )),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width / 1.7,
              child: SvgPicture.asset("assets/logo.svg",fit: BoxFit.cover,)),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)]),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  hintStyle: TextStyle(fontSize: 15),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: "Search for subject (general studies)",
                    // contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Chapters Wise Distribution",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.start,
                )),
          ),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: chapters.length,
              itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  setChapters(chapters[index].id,chapters[index].name, widget.subcourseName!);
                  print(chapters[index].id+ widget.subcourseName!);
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 3
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20))

                            ),
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    width: 80,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2.5
                                          )
                                        ],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)
                                        ),
                                        color: Color(0xffCACCEE)

                                    ),
                                    child: Center(child: Text("Chapters ${index +1}")),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(chapters[index].name),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffBF6196), width: 5),
                              image:
                                  const DecorationImage(image: AssetImage("assets/h.jpg")),
                              borderRadius: const BorderRadius.all(Radius.circular(100))),
                          height: 80,
                          width: MediaQuery.of(context).size.width * 0.2,
                        )
                      ],
                    ),
                  ),
              );
            },),
          ),
        ],
      ),
    );
  }
}
