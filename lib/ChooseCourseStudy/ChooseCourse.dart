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

    return ApiServicesforCourses.getAllCourses().asStream();
  }



  Future<void> _showAlertDialog(String text ,   List<SubCourse>  subcourses) async {
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
                            print(text);
                            Get.to(() => BottomNavBar(page: 0,subcourses :subcourses ,courseName: text));
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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

            Expanded(
              child: StreamBuilder<List<Course>>(
                stream: getOrderStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final courses = snapshot.data!;
                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(const Color(0xffF9F4AC)),
                                  ),
                                  onPressed: () {
                                    print(course.subCourses[index].runtimeType);
                                    _showAlertDialog(course.name , course.subCourses);
                                  },
                                  child: Text(
                                    course.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xffF9F4AC), width: 5),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/h.jpg"),
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                ),
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.3 - 20,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
