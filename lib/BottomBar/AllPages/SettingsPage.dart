import 'package:brainboosters/FeedbackPage/FeedbackPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<IconData> icons = [
    Icons.music_note,
    Icons.color_lens_outlined,
    Icons.phone_android,
    Icons.notifications,
    Icons.book_outlined,
    Icons.star,
    Icons.share,
    Icons.person
  ];
  List text = [
    "Music",
    "Toggle the colorblind tool",
    "Toggle Shakes in the phone",
    "Toggle Push Notification",
    "Change Course of Study",
    "Send Feedback",
    "Share App",
    "Log Out"

  ];
  List<Function> onPressedFunctions = [];
  @override
  void initState(){
    super.initState();


  }


  @override
  Widget build(BuildContext context) {

    onPressedFunctions = [

          () {
        print("object");
        // Function 1
        // Add your code here
      },
          () {
        // Function 2
        // Add your code here
      },
          () {
        // Function 3
        // Add your code here
      },
          () {
        // Function 4
        // Add your code here
      },
          () {
        // Function 5
        // Add your code here
      },
          () {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return FeedBackScreen();
      }));
        // Function6 6
        // Add your code here
      },
          () {
        // Function 7
        // Add your code here
      },
          (){
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Icon(Icons.person, color: Colors.black),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Are you sure you want to Logout?'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    SizedBox(
                      height: 28,
                      width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          backgroundColor:
                          MaterialStateProperty.all(const Color(0xff494FC7)),
                        ),
                        child: const Text('Confirm'),
                        onPressed: () {
                          // Add your logic here
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      height: 28,
                      width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                    ),

                  ],
                );
              },
            );
      }
      // Add more functions as needed
    ];

    return Scaffold(
      body: Column(
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
                  width: MediaQuery.of(context).size.width * 0.35,
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
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset("assets/logo.svg"),
              const SizedBox(width: 10,)
            ],
          ),
          const SizedBox(height: 20,),

          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
              return button(icons[index] ,text[index] , onPressedFunctions[index]);
            },),
          )

        ],
      ),
    );
  }
  Widget button(icons ,text , onpressed){
    return Padding (
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 45,
        width: MediaQuery.sizeOf(context).width,
        // decoration: const BoxDecoration(
        //   color: Colors.white,
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey,
        //       blurRadius: 2.5
        //     )
        //   ]
        //
        // ),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)
          ),
          onPressed: onpressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(icons,color: Colors.black,),
                  SizedBox(width: 10,),
                  Text(text,style: TextStyle(color: Colors.black),),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


