import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({Key? key}) : super(key: key);

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
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
                        "My Main People",
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

        ],
      ),
    );
  }
}
