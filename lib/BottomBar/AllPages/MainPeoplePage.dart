import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainPeoplePage extends StatefulWidget {
  const MainPeoplePage({Key? key}) : super(key: key);

  @override
  State<MainPeoplePage> createState() => _MainPeoplePageState();
}

class _MainPeoplePageState extends State<MainPeoplePage> {
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
                  width: MediaQuery.of(context).size.width * 0.5,
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
                    "My Main People",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset("assets/logo.svg"),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffABADE3),
              ),
              height: 80,
              width: MediaQuery.sizeOf(context).width * 0.9,
            ),
          )
        ],
      ),
    );
  }
}
