import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'ChooseYourChaptersforQuize.dart';

class ChooseYourStudyForQuiz extends StatefulWidget {
  const ChooseYourStudyForQuiz({Key? key}) : super(key: key);

  @override
  State<ChooseYourStudyForQuiz> createState() => _ChooseYourStudyForQuizState();
}

class _ChooseYourStudyForQuizState extends State<ChooseYourStudyForQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 4,
              decoration: const BoxDecoration(
                  color: Color(0xff494FC7),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(150))),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
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
                            width: MediaQuery.sizeOf(context).width * 0.6,
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
                                            Navigator.of(context).pop();
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
                                    "Choose your Study",
                                    style: TextStyle(
                                        color: Color(0xff494FC7), fontSize: 17),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "    Make your future",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
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
                        height: MediaQuery.sizeOf(context).height / 3,
                        child: Transform.translate(
                            offset: const Offset(25, 0),
                            child: SvgPicture.asset(
                              "assets/study.svg",
                              fit: BoxFit.cover,
                            )),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SvgPicture.asset("assets/logo.svg"),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)]),
              height: 40,
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "Search for subject ( general studies )",
                      // contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                      height: 80,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ChooseYourChaptersForQuiz();
                            }));
                          },
                          child: Text(
                            "Health Care",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffCACCEE), width: 5),
                        image:
                            DecorationImage(image: AssetImage("assets/gs.jpg")),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    height: 80,
                    width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                      height: 80,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {},
                          child: Text(
                            "Engineering",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffBF6196), width: 5),
                        image:
                            DecorationImage(image: AssetImage("assets/ce.jpg")),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    height: 80,
                    width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                      height: 80,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {},
                          child: Text(
                            "Ethics",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffF4EA5A), width: 5),
                        image:
                            DecorationImage(image: AssetImage("assets/h.jpg")),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    height: 80,
                    width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                      height: 80,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {},
                          child: Text(
                            "G-Studies",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                          ))),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff48A4E3), width: 5),
                        image:
                            DecorationImage(image: AssetImage("assets/e.jpg")),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    height: 80,
                    width: MediaQuery.sizeOf(context).width * 0.3 - 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
