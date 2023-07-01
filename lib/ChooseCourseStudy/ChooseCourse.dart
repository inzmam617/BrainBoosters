import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../ApiServices/ApiForgettingAlltheCourses.dart';
import '../BottomBar/BottomNavBar.dart';
import '../Models/CoursesModels.dart';

class ChooseCoursePage extends StatefulWidget {
  const ChooseCoursePage({Key? key}) : super(key: key);

  @override
  State<ChooseCoursePage> createState() => _ChooseCoursePageState();
}


class _ChooseCoursePageState extends State<ChooseCoursePage> {


  Stream<List<Course>> getOrderStream() {
    // Adjust this according to your implementation, e.g., using a stream controller or a stream from a provider.
    return ApiServices.getAllCourses().asStream();
  }

  // Future<Uint8List> generate(String query) async {
  //   // Call the runAI method with the required parameters
  //   Uint8List image = await ai.runAI(query, AIStyle.noStyle);
  //   return image;
  // }

  Future<void> _showAlertDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: Text(text),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('Are you sure want to continue with $text?'),
              ],
            ),
          ),
            actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(
                        height: 30,

                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)))),
                              backgroundColor:
                              MaterialStateProperty.all(const Color(0xff494FC7))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                            child: Text('Confirm'),
                          ),
                          onPressed: () {
                            Get.to(() =>const BottomNavBar(page: 0,));

                          },
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)))),
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                            child: Text('Back',style: TextStyle(color: Colors.black),),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          const SizedBox(height: 55,),
          Align(alignment: Alignment.topLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: 35,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.5
                )
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)
              ),
              color: Color(0xff494FC7)
            ),
            child: const Center(child: Text("Choose Your Course",style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,)),
          ),),
          const SizedBox(height: 30,),
          SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width / 1.7,
              child: SvgPicture.asset("assets/logo.svg",fit: BoxFit.cover,)),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         height: 100,
          //           width: MediaQuery.of(context).size.width * 0.6,
          //           child: ElevatedButton(
          //               style: ButtonStyle(
          //                   shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(20)))),
          //                   backgroundColor:
          //                   MaterialStateProperty.all(const Color(0xffE4E5F6))),
          //               onPressed: (){
          //                 _showAlertDialog("General Studies");
          //
          //                 }, child: const Text("General Studies",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
          //       const SizedBox(width: 10,),
          //       Container(
          //         decoration: BoxDecoration(
          //           border: Border.all(color:const Color(0xffE4E5F6),width: 5),
          //           image: const DecorationImage(image: AssetImage("assets/gs.jpg")),
          //
          //           borderRadius: const BorderRadius.all(Radius.circular(100))
          //         ),
          //         height: 100,
          //         width: MediaQuery.of(context).size.width * 0.3 - 20,
          //       )
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 30,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         height: 100,
          //           width: MediaQuery.of(context).size.width * 0.6,
          //           child: ElevatedButton(
          //               style: ButtonStyle(
          //                   shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(20)))),
          //                   backgroundColor:
          //                   MaterialStateProperty.all(const Color(0xffDFAFCA))),
          //               onPressed: (){
          //                 _showAlertDialog("Construction And Civil Engineering");
          //
          //               }, child: const Text("Construction And Civil Engineering",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),textAlign: TextAlign.center,))),
          //       const SizedBox(width: 10,),
          //       Container(
          //         decoration: BoxDecoration(
          //             border: Border.all(color:const Color(0xffDFAFCA),width: 5),
          //             image: const DecorationImage(image: AssetImage("assets/ce.jpg")),
          //
          //             borderRadius: const BorderRadius.all(Radius.circular(100))
          //         ),
          //         height: 100,
          //         width: MediaQuery.of(context).size.width * 0.3 - 20,
          //       )
          //     ],
          //   ),
          // ),

          Expanded(

            child:
            StreamBuilder<List<Course>>(
              stream: getOrderStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final courses = snapshot.data;
                  return ListView.builder(
                    itemCount: courses!.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20)))),
                                        backgroundColor:
                                        MaterialStateProperty.all(const Color(0xffF9F4AC))),
                                    onPressed: (){
                                      _showAlertDialog(course.name);

                                    }, child:  Text(course.name,style: const TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
                            const SizedBox(width: 10,),

                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color:const Color(0xffF9F4AC),width: 5),
                                  image: const DecorationImage(image: AssetImage("assets/h.jpg")),

                                  borderRadius: const BorderRadius.all(Radius.circular(100))
                              ),
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.3 - 20,
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
      // SizedBox(
      //   height: 100,
      //   child: FutureBuilder<Uint8List>(
      //     // Call the generate() function to get the image data
      //     future: generate('Logo that says Computer'),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState ==
      //           ConnectionState.waiting) {
      //         // While waiting for the image data, display a loading indicator
      //         return const CircularProgressIndicator();
      //       } else if (snapshot.hasError) {
      //         // If an error occurred while getting the image data, display an error
      //         return Text('Error: ${snapshot.error}');
      //       } else if (snapshot.hasData) {
      //         // If the image data is available, display the image using Image.memory()
      //         return Image.memory(snapshot.data!);
      //       } else {
      //         // If no data is available, display a placeholder or an empty container
      //         return Container();
      //       }
      //     },
      //   ),
      // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         height: 100,
          //           width: MediaQuery.of(context).size.width * 0.6,
          //           child: ElevatedButton(
          //               style: ButtonStyle(
          //                   shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(20)))),
          //                   backgroundColor:
          //                   MaterialStateProperty.all(const Color(0xffF9F4AC))),
          //               onPressed: (){
          //                 _showAlertDialog("Health Care");
          //
          //               }, child: const Text("Health Care",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
          //       const SizedBox(width: 10,),
          //       Container(
          //         decoration: BoxDecoration(
          //             border: Border.all(color:const Color(0xffF9F4AC),width: 5),
          //             image: const DecorationImage(image: AssetImage("assets/h.jpg")),
          //
          //             borderRadius: const BorderRadius.all(Radius.circular(100))
          //         ),
          //         height: 100,
          //         width: MediaQuery.of(context).size.width * 0.3 - 20,
          //       )
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 30,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         height: 100,
          //           width: MediaQuery.of(context).size.width * 0.6,
          //           child: ElevatedButton(
          //               style: ButtonStyle(
          //                   shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(20)))),
          //                   backgroundColor:
          //                   MaterialStateProperty.all(const Color(0xffA3D1F1))),
          //               onPressed: (){
          //                 _showAlertDialog("English");
          //
          //               }, child: const Text("English",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
          //       const SizedBox(width: 10,),
          //       Container(
          //         decoration: BoxDecoration(
          //             border: Border.all(color:const Color(0xffA3D1F1),width: 5),
          //             image: const DecorationImage(image: AssetImage("assets/e.jpg")),
          //
          //             borderRadius: const BorderRadius.all(Radius.circular(100))
          //         ),
          //         height: 100,
          //         width: MediaQuery.of(context).size.width * 0.3 - 20,
          // //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
