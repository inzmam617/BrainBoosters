import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashPage extends StatefulWidget {
  const DashPage({Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
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
              SvgPicture.asset("assets/logo.svg",fit: BoxFit.scaleDown,),
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
                      padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Play" ,style: TextStyle(color: Colors.green),),
                              Text("205")
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Winning" ,style: TextStyle(color: Colors.blue),),
                              Text("205")
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Loose" ,style: TextStyle(color: Colors.red),),
                              Text("205")
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Points" ,style: TextStyle(color: Colors.orange),),
                              Row(
                                children: [
                                  Text("205"),
                                  Icon(Icons.star,color: Colors.orange,)
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
          SizedBox(height: 50,),
          SizedBox(
              height: 35,
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)))),
                      backgroundColor:
                      MaterialStateProperty.all(Color(0xff494FC7))),
                  onPressed: () {},
                  child: Text(
                    "Play",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ))),
        ],
      ),
    );
  }
}
