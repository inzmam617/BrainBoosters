import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  Widget build(BuildContext context) {
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
                  height: 40,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 3.5)
                      ],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Color(0xff494FC7)),
                  child: Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: IconButton(
                          onPressed: () {
                           Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Text(
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset("assets/logo.svg"),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.32,
            width: MediaQuery.of(context).size.height * 0.32,
            decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(360))),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(360))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset("assets/feed.svg"),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          const Center(
            child: Text('How Would you \n Rate Our App Experience ?',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w200),textAlign: TextAlign.center,),
          ),
          const SizedBox(height: 30,),

          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
            },
          ),
          const SizedBox(height: 20,),
          const Text("Select One")
        ],
      ),
    );
  }
}
