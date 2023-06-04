import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../BottomBar/BottomNavBar.dart';

class ChooseCoursePage extends StatefulWidget {
  const ChooseCoursePage({Key? key}) : super(key: key);

  @override
  State<ChooseCoursePage> createState() => _ChooseCoursePageState();
}

class _ChooseCoursePageState extends State<ChooseCoursePage> {

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      SizedBox(
                        height: 30,

                        width: 150,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)))),
                              backgroundColor:
                              MaterialStateProperty.all(const Color(0xff494FC7))),
                          child: const Text('Yes'),
                          onPressed: () {
                            Get.to(() =>const BottomNavBar(page: 0,));

                          },
                        ),
                      ),

                      SizedBox(
                        height: 30,
                        width: 150,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)))),
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                          child: const Text('Back',style: TextStyle(color: Colors.black),),
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
          const SizedBox(height: 35,),
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

          SvgPicture.asset("assets/logo.svg"),
          const SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)))),
                            backgroundColor:
                            MaterialStateProperty.all(const Color(0xffCACCEE))),
                        onPressed: (){
                          _showAlertDialog("General Studies");

                          }, child: const Text("General Studies",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
                const SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color:const Color(0xffCACCEE),width: 5),
                    image: const DecorationImage(image: AssetImage("assets/gs.jpg")),

                    borderRadius: const BorderRadius.all(Radius.circular(100))
                  ),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)))),
                            backgroundColor:
                            MaterialStateProperty.all(const Color(0xffBF6196))),
                        onPressed: (){
                          _showAlertDialog("Construction And Civil Engineering");

                        }, child: const Text("Construction And Civil Engineering",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),textAlign: TextAlign.center,))),
                const SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color:const Color(0xffBF6196),width: 5),
                      image: const DecorationImage(image: AssetImage("assets/ce.jpg")),

                      borderRadius: const BorderRadius.all(Radius.circular(100))
                  ),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)))),
                            backgroundColor:
                            MaterialStateProperty.all(const Color(0xffF4EA5A))),
                        onPressed: (){
                          _showAlertDialog("Health Care");

                        }, child: const Text("Health Care",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
                const SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color:const Color(0xffF4EA5A),width: 5),
                      image: const DecorationImage(image: AssetImage("assets/h.jpg")),

                      borderRadius: const BorderRadius.all(Radius.circular(100))
                  ),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)))),
                            backgroundColor:
                            MaterialStateProperty.all(const Color(0xff48A4E3))),
                        onPressed: (){
                          _showAlertDialog("English");

                        }, child: const Text("English",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
                const SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color:const Color(0xff48A4E3),width: 5),
                      image: const DecorationImage(image: AssetImage("assets/e.jpg")),

                      borderRadius: const BorderRadius.all(Radius.circular(100))
                  ),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),



        ],

      ),
    );
  }
}
