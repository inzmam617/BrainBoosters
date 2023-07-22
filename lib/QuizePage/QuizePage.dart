import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../ApiServices/ApiForGettingQuizes.dart';
import '../Models/CoursesModels.dart';
import '../Models/QuizModels.dart';
import '../Quiz Model/QuizModelClass.dart';


class QuizPage extends StatefulWidget {
  final List<SubCourse>?  subcourses;
  final String? courseName;
  const QuizPage({Key? key, this.subcourses, this.courseName}) : super(key: key);
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {


  Timer? _timer;
  int _seconds = 127;
  late ConfettiController _confettiController;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  List<QuizQuestion> quizQuestions=[];
  @override
  void initState() {
    super.initState();
    print(widget.courseName);
    print(widget.subcourses);
    _startTimer();
    colorSelect();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _assetsAudioPlayer.open(
      Playlist(
        audios: [
          Audio('assets/audio/medieval-fanfare-6826.mp3'),
          Audio('assets/audio/let-it-go-12279.mp3'),
          Audio('assets/audio/fast tempo.mp3'),
          Audio('assets/audio/medium tempo.mp3'),
          // Add more audio tracks here...
        ],
      ),
      showNotification: true,
      autoStart: false,
      loopMode: LoopMode.single
    );
  }
  StreamController<List<QuizQuestion>> quizQuestionsController = StreamController<List<QuizQuestion>>();
  Future<List<QuizQuestion>>? loadQuizQuestions() async {
    try {
       if(count==0){
         quizQuestions = await QuizApiService.getQuizQuestions(
           (widget.courseName!).toString(),
           (widget.subcourses![0].name).toString(),
           (widget.subcourses![0].chapters[0].name).toString(),
         );
       }
      return quizQuestions;
    } catch (e) {
      print('Failed to fetch quiz questions: $e');
    }
    return[];
  }
  colorSelect(){
    int randomIndex = Random().nextInt(colorList.length);
    setState(() {
      color = colorList[randomIndex];
    });
  }
  @override
  void dispose() {
    _confettiController.dispose();
    _timer?.cancel();
    super.dispose();
  }
  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }
  Color color = Colors.transparent;
  List<Color> colorList = [
    Colors.orangeAccent,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.deepPurpleAccent,
  ];

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
  String choose = "";
  Future<void> _showAlertDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title: const Text('Confirm'),
          content:  const SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('Are you sure want to Leave Quiz?'),
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
                    child: const Text('Yes'),
                    onPressed: () {
                      _assetsAudioPlayer.stop();
                     Get.back();
                     Get.back();




                    },
                  ),
                ),
                const SizedBox(width: 20,),

                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      // foregroundColor: MaterialStateProperty.all(Colors.black),
                      // overlayColor: MaterialStateProperty.all(Colors.black),
                        // shadowColor: MaterialStateProperty.all(Colors.black),
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

  AlertDialog showAlertDialogForMusic() {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Music', textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                height: 35,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.5,
                    ),
                  ],
                  color:  Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    _assetsAudioPlayer.playlistPlayAtIndex(2);

                  },
                  child: const Center(
                    child: Text(
                      "Fast-Tempo",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 35,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.5,
                    ),
                  ],
                  color:   Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    _assetsAudioPlayer.playlistPlayAtIndex(3);


                  },
                  child: const Center(
                    child: Text(
                      "Medium-Tempo",
                      style: TextStyle(
                        color:  Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 35,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.5,
                    ),
                  ],
                  color:  Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    _assetsAudioPlayer.playlistPlayAtIndex(1);

                  },
                  child: const Center(
                    child: Text(
                      "Slow-Tempo",
                      style: TextStyle(
                        color:  Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 35,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.5,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    _assetsAudioPlayer.stop();

                  },
                  child: const Center(
                    child: Text(
                      "  Stop All  ",
                      style: TextStyle(
                        color:  Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(const Color(0xff494FC7)),
                  ),
                  child: const Text('Done'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text('Back', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  bool shouldRevealAnswer = false;
  int currentQuestionIndex = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6768b0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 35,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 3.5)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Color(0xff494FC7)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: SizedBox(
                              width: 30,
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
                                    _showAlertDialog();
                                  },
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 10,
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          const Text(
                            "Quiz Page",
                            style: TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(width: 5,),

                        ],
                      ),
                    )),
                  ),
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
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 130,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 3.5)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),

                          Text(
                            "${_formatDuration(Duration(seconds: _seconds))} sec",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 3.3)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Center(
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return showAlertDialogForMusic();
                              },
                            );
                          },
                      icon: const Icon(Icons.music_note,size: 20,),
                    )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder<List<QuizQuestion>>(
              future: count==0?loadQuizQuestions():hello(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<QuizQuestion> questionList = snapshot.data!;
                  count=questionList.length;
                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)],
                                color: Colors.yellow,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 35,
                              child: Center(
                                child: Text(
                                  "Question (${currentQuestionIndex + 1}/${questionList.length})",
                                  style: const TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Text(
                                  questionList[currentQuestionIndex].question,
                                  style: const TextStyle(color: Colors.black, fontSize: 17),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,)


                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 25,
                            left: 25,
                            right: 25,
                            top: 10
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.28,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 20,
                              childAspectRatio: 2.0, // Adjust the aspect ratio as needed
                            ),
                            itemCount: questionList[currentQuestionIndex].options.length,
                            itemBuilder: (BuildContext context, int index) {
                              String answer = questionList[currentQuestionIndex].answer;

                              return SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.5, // Adjust the width as needed
                                height: 220, // Adjust the height as needed
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                        if (states.contains(MaterialState.pressed)) {
                                          // Button is pressed
                                          return color;
                                        } else if (shouldRevealAnswer) {
                                          // Reveal the correct answer
                                          if (questionList[currentQuestionIndex].options[index].toString()==questionList[currentQuestionIndex].answer.toString()) {

                                            return Colors.green;
                                          } else if (questionList[currentQuestionIndex].options[index].toString()!=questionList[currentQuestionIndex].answer.toString()) {
                                            // Selected answer and it is wrong
                                            return Colors.black;
                                          } else {
                                            return Colors.red;
                                          }
                                        }
                                        // else if (selectedAnswer != null && answer == selectedAnswer) {
                                        //   // Selected answer
                                        //   return Colors.black;
                                        // }
                                        else {
                                          // Default color
                                          return color;
                                        }
                                      },
                                    ),



                                  ),
                                  onPressed: () async{

                                    if(questionList[currentQuestionIndex].options[index].toString()==questionList[currentQuestionIndex].answer.toString()){
                                      print("Match");

                                    }


                                      // if (questionList[currentQuestionIndex].options[index] == questionList[currentQuestionIndex].answer) {
                                      //
                                      //   print(currentQuestionIndex + 1);
                                      // }



                                    // print("Clicked item index: $index");
                                    // print(questionList[currentQuestionIndex].options);



                                  },
                                  child: Center(
                                    child: Text(
                                      questionList[currentQuestionIndex].options[index],
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox(); // Return an empty widget if no data is available
                }
              },
            ),
            // const SizedBox(height: 50,),
            //
            // ElevatedButton(
            //   onPressed: () async{
            //     if (currentQuestionIndex + 1 < count) {
            //       setState(() {
            //         currentQuestionIndex++;
            //       });
            //     }
            //     else{
            //
            //     }
            //   },
            //   child: const Text('Next Question'),
            // ),
            //
            // ElevatedButton(
            //   onPressed: () {
            //
            //   },
            //   child: const Text('Load Quiz Questions'),
            // ),
            //















            SizedBox(
                height: 35,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)))),
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xff494FC7))),
                    onPressed: () {

                      if (currentQuestionIndex + 1 < count) {
                        setState(() {
                          currentQuestionIndex++;
                        });
                      }
                      else{
                        print(currentQuestionIndex);

                      }

                    },
                    child: currentQuestionIndex + 1 < count? const Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ) : const Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    )
                )),

          ],
        ),
      ),
    );
  }

  hello() {}
}


