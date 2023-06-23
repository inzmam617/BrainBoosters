import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import '../Quiz Model/QuizModelClass.dart';

import 'package:http/http.dart' as http;

import '../Quiz Model/QuizModelClass.dart';

// class Question {
//   final String questionText;
//   final List<Answer> answersList;
//
//   Question(this.questionText, this.answersList);
// }
//
// class Answer {
//   final String answerText;
//   final bool isCorrect;
//
//   Answer(this.answerText, this.isCorrect);
// }

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Timer? _timer;
  int _seconds = 127;

  late ConfettiController _confettiController;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    // fetchQuestions();
    questionList = getQuestions();

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
// Generate a random index within the range of the colorList

  }

  colorSelect(){
    int randomIndex = Random().nextInt(colorList.length);

// Assign the randomly selected color to the 'color' variable
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
          content:  SingleChildScrollView(
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
                     Get.back();
                     Get.back();
                     _assetsAudioPlayer.stop();



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



  // Future<void> fetchQuestions() async {
  //   print("object");
  //   final response = await http.get(Uri.parse('http://192.168.0.75:6222/getChapters'));
  //   print("this is the body" + response.body);
  //
  //
  //   if (response.statusCode == 200) {
  //     print("this is the body" + response.body);
  //     final data = jsonDecode(response.body);
  //     List<Question> fetchedQuestions = [];
  //
  //     for (var questionData in data) {
  //       String questionText = questionData['questionText'];
  //       List<Answer> answersList = [];
  //
  //       for (var answerData in questionData['answersList']) {
  //         String answerText = answerData['answerText'];
  //         bool isCorrect = answerData['isCorrect'];
  //
  //         answersList.add(Answer(answerText, isCorrect));
  //       }
  //
  //       fetchedQuestions.add(Question(questionText, answersList));
  //     }
  //
  //     setState(() {
  //       questionList = fetchedQuestions;
  //     });
  //   } else {
  //     throw Exception('Failed to fetch questions');
  //   }
  // }

  bool shouldRevealAnswer = false;
  List<Question> questionList = [];
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    _showAlertDialog();
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
                          const SizedBox(width: 5,),
                          const Text(
                            "Programming Test",
                            style: TextStyle(
                                color: Colors.white, fontSize: 14),
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
            Container(
              decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.5)],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 150,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 3.5)
                        ],
                        color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 35,
                    child: Center(
                      child: Text(
                        "Question (${currentQuestionIndex + 1}/${questionList.length})",
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: Text(
                      questionList[currentQuestionIndex].questionText.toString(),

                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
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
                  itemCount: questionList[currentQuestionIndex].answersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Answer answer = questionList[currentQuestionIndex].answersList[index];

                    return SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.4, // Adjust the width as needed
                      height: 200, // Adjust the height as needed
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
                                    if (answer.isCorrect) {

                                      return Colors.green;
                                    } else if (selectedAnswer == answer) {
                                      // Selected answer and it is wrong
                                      return Colors.black;
                                    } else {
                                      return Colors.red;
                                    }
                                  } else if (selectedAnswer != null && answer == selectedAnswer) {
                                    // Selected answer
                                    return Colors.black;
                                  } else {
                                    // Default color
                                    return color;
                                  }
                            },
                          ),
//                             backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                                   (Set<MaterialState> states) {
//                                 if (states.contains(MaterialState.pressed)) {
//                                   // Button is pressed
//                                   return color;
//                                 } else if (shouldRevealAnswer) {
//                                   // Reveal the correct answer
//                                   if (answer.isCorrect && selectedAnswer == answer) {
//                                     // Selected answer is correct
//                                     _confettiController.play();
// // Play confetti effect
//                                     Future.delayed(const Duration(seconds: 1), () {
//                                       _confettiController.stop(); // Stop confetti effect after 4 seconds
//
//                                     });
//                                     return Colors.green;
//                                   } else if (answer.isCorrect) {
//                                     // Correct answer, but it's not selected
//                                     return Colors.green;
//                                   } else if (selectedAnswer == answer) {
//                                     // Selected answer and it is wrong
//                                     return Colors.black;
//                                   } else {
//                                     return Colors.red;
//                                   }
//                                 } else if (selectedAnswer != null && answer == selectedAnswer) {
//                                   // Selected answer
//                                   return Colors.black;
//                                 } else {
//                                   // Default color
//                                   return color;
//                                 }
//                               },
//                             ),
                        ),
                        onPressed: () {
                          if(selected){

                          }else {
                            setState(() {
                              selectedAnswer = answer;
                              choose = "answer";
                              selected = true;
                            });
                            shouldRevealAnswer = true;
                            if (selectedAnswer?.isCorrect == true) {
                              score++;
                            } else {

                            }
                          }
                        },
                        child: Center(
                          child: Text(
                            answer.answerText,
                            style: const TextStyle(
                              fontSize: 20,
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


            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.directional,
              blastDirection: -pi /2, // Emit confetti at a diagonal direction
              emissionFrequency: 0.05, // How often confetti is emitted
              numberOfParticles: 10, // Increase the number of particles
              gravity: 0.4, // Increase the gravity to make confetti fall faster
              shouldLoop: false, // Stop after a single emission
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ], // Colors of confetti particles
            ),


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


                       if (choose != "") {
                         if (currentQuestionIndex + 1 == questionList.length) {
                           Get.back();
                         }
                         else {

                             setState(() {
                               // print(questionList[currentQuestionIndex].answersList[currentQuestionIndex].answerText);
                               currentQuestionIndex++;
                               colorSelect();
                               shouldRevealAnswer = false;
                               choose = "";
                               selected = false;
                             });

                         }
                       }
                       else {
                         ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(
                               content: Text('Please Select an Answer'),
                               duration: Duration(seconds: 1),

                             ));
                       }

                    },
                    child: currentQuestionIndex + 1 == questionList.length ? const Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ) : const Text(
                      "Next",
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
}


