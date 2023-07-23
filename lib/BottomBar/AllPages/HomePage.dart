import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiServices/ApiServicetogetSpecificChaptersLists.dart';
import '../../Models/CoursesModels.dart';


class HomePage extends StatefulWidget {
  List<Chapter> chapters;
  final String? courseName;
  HomePage({Key? key, required this.chapters, this.courseName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> chapters = [];
@override
  void initState(){
  super.initState();
  initilize();

  // setState(() {
  //   chapters.addAll( widget.chapters);
  // });
  // print(chapters);


}

  Future<List<String>> fetchChapters() async {
    // Replace this with the actual API call to get the chapters list
    final chapters = await ApiServicetogetSpecificChaptersLists.getChaptersLists(id!);
    return chapters.chapters;
  }


String? chapterName = "Nothing";
String? courseName  = "Nothing";
String? id  = "Nothing";
Future<void> initilize() async {
  final SharedPreferences prefs =  await SharedPreferences.getInstance();
  setState(() {
    chapterName =  prefs.getString("chapterName");
    courseName =  prefs.getString("courseName");
    id =  prefs.getString("chapterId");
  });
  ApiServicetogetSpecificChaptersLists.getChaptersLists(id!);
}
  List <String> names  = [];
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

              const SizedBox(
                width: 10,
              ),
            ],
          ),

          const SizedBox(
            height: 30,
          ),
          SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width / 1.7,
              child: SvgPicture.asset("assets/logo.svg",fit: BoxFit.cover,)),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  // width: MediaQuery.of(context).size.width / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Selected Course:" ,style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),

                        Text("Selected Sub-Course:" ,style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),),

                      ],
                    )),
                const SizedBox(width: 20,),
                SizedBox(
                    // width: MediaQuery.of(context).size.width / 2.5,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text("  $courseName"),
                        const SizedBox(height: 10,),

                        Text("  $chapterName"),

                      ],
                    ))
              ],
            ),
          ),


          // Expanded(child: ListView.builder(
          //   itemCount: chapters.length,
          //   itemBuilder: (context, index) {
          //     return  Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //       child: Row(
          //         children: [
          //           SizedBox(
          //               width: MediaQuery.of(context).size.width * 0.6,
          //               child: ElevatedButton(
          //                   style: ButtonStyle(
          //                       shape: MaterialStateProperty.all(
          //                           const RoundedRectangleBorder(
          //                               borderRadius:
          //                               BorderRadius.all(Radius.circular(10)))),
          //                       backgroundColor: MaterialStateProperty.all(
          //                           const Color(0xffE6EED9))),
          //                   onPressed: () {
          //                     // _show3list(chapters[index].chapters);
          //
          //                   },
          //                   child:   Padding(
          //                     padding: const EdgeInsets.symmetric(vertical: 20),
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //
          //                           chapters[index].name,
          //                           style: const TextStyle(
          //
          //
          //
          //                               color: Colors.black,
          //
          //                               fontSize: 15,
          //                               fontWeight: FontWeight.w300),
          //                         ),
          //                         // Text(
          //                         //   "${chapters.length} Chapters",
          //                         //   style: const TextStyle(
          //                         //       color: Colors.black,
          //                         //       fontSize: 14,
          //                         //       fontWeight: FontWeight.w300),
          //                         // ),
          //
          //                       ],
          //                     ),
          //                   ))),
          //           const SizedBox(
          //             width: 20,
          //           ),
          //           Container(
          //             decoration: BoxDecoration(
          //                 border:
          //                 Border.all(color: const Color(0xffE6EED9), width: 5),
          //                 image: const DecorationImage(
          //                     image: AssetImage("assets/four.jpg")),
          //                 borderRadius:
          //                 const BorderRadius.all(Radius.circular(100))),
          //             height: 80,
          //             width: MediaQuery.of(context).size.width * 0.2,
          //           )
          //         ],
          //       ),
          //     );
          //   },
          // )),



          FutureBuilder<List<String>>(
            future: fetchChapters(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the future to complete, show a loading indicator
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If an error occurred while fetching data, display an error message
                return Text("Error: ${snapshot.error}");
              }
              else if (snapshot.data!.isEmpty) {
                // If an error occurred while fetching data, display an error message
                return const Text("Please Select Any Subject");
              }

              else {
                // If the future completed successfully, display the chapters
                 chapters = snapshot.data!;
                return

                Expanded(child: ListView.builder(
                  itemCount: chapters.length,
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
                                              BorderRadius.all(Radius.circular(10)))),
                                      backgroundColor: MaterialStateProperty.all(
                                          const Color(0xffE6EED9))),
                                  onPressed: () {
                                    // _show3list(chapters[index].chapters);

                                  },
                                  child:   Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(

                                           chapters![index],
                                          style: const TextStyle(



                                              color: Colors.black,

                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        // Text(
                                        //   "${chapters.length} Chapters",
                                        //   style: const TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 14,
                                        //       fontWeight: FontWeight.w300),
                                        // ),

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
                ));







                //   Expanded(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: chapters.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text(chapters![index]),
                //       );
                //     },
                //   ),
                // );
              }
            },
          ),


          const SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }
}
