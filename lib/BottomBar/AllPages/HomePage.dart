import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../ApiServices/ApiForGettingQuizes.dart';
import '../../ApiServices/ApiForgettingAlltheCourses.dart';
import '../../Models/CoursesModels.dart';
import '../../Models/QuizModels.dart';
import '../../QuizePage/QuizePage.dart';
import '../BottomNavBar.dart';
import 'ChooseYourStudyforQuize.dart';


class HomePage extends StatefulWidget {
  final List<SubCourse>?  subcourses;
  final String? courseName;


  HomePage({Key? key, this.subcourses, this.courseName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List <SubCourse> sub = [];
@override
  void initState(){
  super.initState();
  setState(() {
    sub.addAll( widget.subcourses!);
  });

  // QuizApiService.getQuizQuestions((widget.courseName!).toString(), (widget. subcourses![0].name).toString(), (widget.subcourses![0].chapters[0].name).toString());


}

  List <String> names  = [];
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
                      Get.back();

                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return  QuizPage(subcourses: widget.subcourses,courseName: widget.courseName,);
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
                            MaterialStateProperty.all(const Color(0xffC94905))),
                    child: const Text(
                      'Invite a Friend',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.back();
                      // Get.to(() => const BottomNavBar(page: 1,));
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                        return  BottomNavBar(page: 1,);
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
                      Get.to(() =>  ChooseYourStudyForQuiz(textList : names ));
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
                  Navigator.of(context).pop();
                  _showAlertDialog();
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
    print(sub[0].name);
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

              const SizedBox(
                width: 10,
              ),
            ],
          ),
          // const SizedBox(
          //   height: 30,
          // ),
          // Container(
          //   decoration: const BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(35)),
          //       color: Colors.white,
          //       boxShadow: [
          //         BoxShadow(color: Colors.grey, blurRadius: 3.5)
          //       ]),
          //   height: 40,
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   child: Center(
          //     child: TextFormField(
          //
          //       decoration: const InputDecoration(
          //         hintStyle: TextStyle(fontSize: 16,),
          //
          //           prefixIcon: Icon(
          //             Icons.search,
          //             color: Colors.grey,
          //           ),
          //           hintText: "Find and replay chapters",
          //           // contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          //           border: InputBorder.none),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width / 1.7,
              child: SvgPicture.asset("assets/logo.svg",fit: BoxFit.cover,)),
          const SizedBox(
            height: 35,
          ),
          Expanded(child: ListView.builder(
            itemCount: sub.length,
            itemBuilder: (context, index) {
              return  Padding(
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
                              _show3list(sub[index].chapters);

                            },
                            child:   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(

                                    "${sub[index].name}",
                                    style: const TextStyle(



                                        color: Colors.black,

                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    "${sub[index].chapters.length} Chapters",
                                    style: const TextStyle(
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
              );
            },
          )),
          // Expanded(
          //
          //   child:
          //   StreamBuilder<List<Course>>(
          //     stream: getOrderStream(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         final courses = snapshot.data;
          //         return ListView.builder(
          //           itemCount: sub.length,
          //           itemBuilder: (context, index) {
          //          return  Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //               child: Row(
          //                 children: [
          //                   SizedBox(
          //                       width: MediaQuery.of(context).size.width * 0.6,
          //                       child: ElevatedButton(
          //                           style: ButtonStyle(
          //                               shape: MaterialStateProperty.all(
          //                                   const RoundedRectangleBorder(
          //                                       borderRadius:
          //                                       BorderRadius.all(Radius.circular(20)))),
          //                               backgroundColor: MaterialStateProperty.all(
          //                                   const Color(0xffE6EED9))),
          //                           onPressed: () {
          //                             _showAlertDialog(course.subCourses);
          //
          //                           },
          //                           child:   Padding(
          //                             padding: const EdgeInsets.all(8.0),
          //                             child: Column(
          //                               mainAxisAlignment: MainAxisAlignment.start,
          //                               crossAxisAlignment: CrossAxisAlignment.start,
          //                               children: [
          //                                 Text(
          //
          //                                   course.name,
          //                                   style: const TextStyle(
          //
          //
          //
          //                                       color: Colors.black,
          //
          //                                       fontSize: 15,
          //                                       fontWeight: FontWeight.w300),
          //                                 ),
          //                                 Text(
          //                                   "${course.subCourses.length} Chapters",
          //                                   style: const TextStyle(
          //                                       color: Colors.black,
          //                                       fontSize: 14,
          //                                       fontWeight: FontWeight.w300),
          //                                 ),
          //
          //                               ],
          //                             ),
          //                           ))),
          //                   const SizedBox(
          //                     width: 20,
          //                   ),
          //                   Container(
          //                     decoration: BoxDecoration(
          //                         border:
          //                         Border.all(color: const Color(0xffE6EED9), width: 5),
          //                         image: const DecorationImage(
          //                             image: AssetImage("assets/four.jpg")),
          //                         borderRadius:
          //                         const BorderRadius.all(Radius.circular(100))),
          //                     height: 80,
          //                     width: MediaQuery.of(context).size.width * 0.2,
          //                   )
          //                 ],
          //               ),
          //             );
          //           },
          //         );
          //       } else if (snapshot.hasError) {
          //         return Center(
          //           child: Text('Error: ${snapshot.error}'),
          //         );
          //       } else {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     },
          //   ),
          // ),

           SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }
}
