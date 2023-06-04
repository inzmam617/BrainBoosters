import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          title: Text('${text}'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('Are you sure want to cancel ${text}?'),
              ],
            ),
          ),
            actions: <Widget>[

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
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                          return const BottomNavBar(page: 0,);
                        }));
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
                        Navigator.of(context).pop();
                      },
                    ),
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
          SizedBox(height: 35,),
          Align(alignment: Alignment.topLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 35,
            decoration: BoxDecoration(
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
            child: Center(child: Text("Choose Your Course Study",style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,)),
          ),),
          SizedBox(height: 30,),

          SvgPicture.asset("assets/logo.svg"),
          SizedBox(height: 30,),

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

                          }, child: Text("General Studies",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
                SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color:Color(0xffCACCEE),width: 5),
                    image: DecorationImage(image: AssetImage("assets/gs.jpg")),

                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          SizedBox(height: 30,),

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

                        }, child: Text("Construction And Civil Engineering",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),textAlign: TextAlign.center,))),
                SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color:Color(0xffBF6196),width: 5),
                      image: DecorationImage(image: AssetImage("assets/ce.jpg")),

                      borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          SizedBox(height: 30,),

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

                        }, child: Text("Health Care",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
                SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color:Color(0xffF4EA5A),width: 5),
                      image: DecorationImage(image: AssetImage("assets/h.jpg")),

                      borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  height: 100,
                  width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                )
              ],
            ),
          ),
          SizedBox(height: 30,),

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

                        }, child: Text("English",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w300),))),
                SizedBox(width: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color:Color(0xff48A4E3),width: 5),
                      image: DecorationImage(image: AssetImage("assets/e.jpg")),

                      borderRadius: BorderRadius.all(Radius.circular(100))
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
