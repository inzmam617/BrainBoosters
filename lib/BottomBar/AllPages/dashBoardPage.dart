import 'package:brainboosters/QuizePage/QuizePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DashPage extends StatefulWidget {
  const DashPage({Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  List<Color> colors = [
    const Color(0xffFFA412),
    const Color(0xff494FC7),
    const Color(0xffC3D7A2),
    const Color(0xff8E7CC3),
    const Color(0xffBF6196),
  ];
  List<String> names = [
    "John Smith",
    "Sarah Johnson",
    "Micheal Williams",
    "Jessica Davids",
    "Christopher Brown"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
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
                      "DashBoard",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "assets/logo.svg",
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/boy.svg"),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)],
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 30,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35)),
                              color: Color(0xffC3D7A2)),
                          child: const Center(
                              child: Text(
                            "Dash History",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Play",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Text("205")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Winning",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                Text("205")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Loose",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text("205")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Points",
                                  style: TextStyle(color: Colors.orange),
                                ),
                                Row(
                                  children: [
                                    Text("205"),
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
                height: 35,
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff494FC7))),
                    onPressed: () {
                      Get.to(() => const QuizPage());
                    },
                    child: const Text(
                      "Play",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ))),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: double.infinity,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Your Last Quiz Result",style: TextStyle(color: Color(0xff494FC7)),)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.04,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(10)),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 3.5)
                                    ],
                                    color: colors[index]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.04 - 10,
                                        width: MediaQuery.of(context).size.height * 0.04 - 10,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(360)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2.5
                                            )
                                          ]
                                        ),
                                        child: Center(child: Text("${index + 1}",style: const TextStyle(color: Colors.black,fontSize: 15),textAlign: TextAlign.center,)),
                                      ),
                                      const SizedBox(width: 20,),
                                      Text(names[index],style: const TextStyle(color: Colors.white,fontSize: 16),)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
