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
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../const.dart';

class QuizPage extends StatefulWidget {
  final List<SubCourse>?  subcourses;
  final String?  subcourseName;
  final String?  MatchType;
  final String?  Id;
  final String?  roomId;
  final String?  chapterName;
  final String? courseName;
  const QuizPage({Key? key, this.subcourses, this.courseName,this.subcourseName,this.chapterName, this.MatchType, this.roomId, this.Id}) : super(key: key);
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  String? selectedOption;
  bool layoutType =false;
  late IO.Socket socket;
  void connectToServer() {
    try {
      print("starting");
      socket = IO.io(baseUrl,IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());
      socket.connect();
    } catch (e) {
      print(e.toString());
    }
  }
  int correctedanswers = 0;
  Timer? _timer;
  int _seconds = 100;
  late ConfettiController _confettiController;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  List<QuizQuestion> quizQuestions=[];
  @override
  void initState() {
    connectToServer();
    print( "this is the match type: ${widget.MatchType}");

    super.initState();
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
      showNotification: false,
      autoStart: false,
      loopMode: LoopMode.single
    );
  }
  StreamController<List<QuizQuestion>> quizQuestionsController = StreamController<List<QuizQuestion>>();
  Future<List<QuizQuestion>>? loadQuizQuestions() async {
    try {
       if(count==0){
         if(widget.subcourseName==null){
           quizQuestions = await QuizApiService.getQuizQuestions(
             (widget.courseName!).toString(),
             (widget.subcourses![0].name).toString(),
             (widget.subcourses![0].chapters[0].name).toString(),
           );
         }
         else{
           quizQuestions = await QuizApiService.getQuizQuestions(
             (widget.courseName!).toString(),
             (widget.subcourseName).toString(),
             (widget.chapterName).toString(),
           );
         }
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Time's Up"),
            duration: Duration(milliseconds: 300),
          ));
          // _showTimeUpDialog(); // Show dialog when the timer reaches zero
        }
      });
    });
  }
  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Time's Up"),
          content: Text("Your time is up!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // void _startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(oneSec, (timer) {
  //     setState(() {
  //       if (_seconds > 0) {
  //         _seconds--;
  //       } else {
  //         _timer?.cancel();
  //       }
  //     });
  //   });
  // }
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

    return WillPopScope(
      onWillPop: () async{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cant leave during Quiz"),
            duration: Duration(seconds: 1),
          ),
        );
        // R
        return false;
      },
      child: Scaffold(
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
                      child: Column(
                        children: [
                          Text("Please wait while your quiz's are loading.."),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  } else
                    if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {

                      count==0?_startTimer():hello();

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
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 25,
                              left: 25,
                              right: 25,
                              top: 10
                          ),
                          child:
                          // layoutType == true
                          //     ? SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.4,
                          //
                          //   child: ListView.builder(
                          //   itemCount: questionList[currentQuestionIndex].options.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //       // Use ListView.builder when any option has a length greater than 10 characters
                          //       // You can adjust the condition based on your preference for the length check
                          //       String answer = questionList[currentQuestionIndex].answer;
                          //
                          //       return  Padding(
                          //         padding: const EdgeInsets.symmetric(vertical: 10.0),
                          //         child: SizedBox(
                          //           height: 50, // Adjust the height as needed to accommodate your content
                          //           child: ElevatedButton(
                          //             style: ButtonStyle(
                          //               shape: MaterialStateProperty.all(
                          //                 const RoundedRectangleBorder(
                          //                   borderRadius: BorderRadius.all(Radius.circular(20)),
                          //                 ),
                          //               ),
                          //               backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          //                     (Set<MaterialState> states) {
                          //                   if (states.contains(MaterialState.pressed)) {
                          //                     // Button is pressed
                          //                     return color;
                          //                   } else if (shouldRevealAnswer) {
                          //                     // Reveal the correct answer
                          //                     if (questionList[currentQuestionIndex].options[index] == questionList[currentQuestionIndex].answer) {
                          //                       // Selected answer and it is correct
                          //                       return Colors.green;
                          //                     } else {
                          //                       // Selected answer and it is wrong
                          //                       return Colors.red;
                          //                     }
                          //                   } else {
                          //                     // Default color
                          //                     return color;
                          //                   }
                          //                 },
                          //               ),
                          //
                          //
                          //
                          //
                          //             ),
                          //             onPressed: () async{
                          //
                          //               if(questionList[currentQuestionIndex].options[index].toString()==questionList[currentQuestionIndex].answer.toString()){
                          //                 print("Match");
                          //
                          //               }
                          //
                          //               setState(() {
                          //                 selectedOption = questionList[currentQuestionIndex].options[index];
                          //                 shouldRevealAnswer = true; // Set to true to reveal the answer
                          //               });
                          //
                          //               if (questionList[currentQuestionIndex].options[index] == questionList[currentQuestionIndex].answer) {
                          //                 correctedanswers ++;
                          //                 print("Correct Answer");
                          //               } else {
                          //                 // Selected answer is wrong
                          //                 print("Wrong Answer");
                          //               }
                          //             },
                          //             child: Center(
                          //               child: Text(
                          //                 questionList[currentQuestionIndex].options[index],
                          //                 style: const TextStyle(
                          //                   fontSize: 15,
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //
                          //         ),
                          //       );
                          //   },
                          // ),
                          //     ) :

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.28,
                            child:

                            GridView.builder(
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
                                            if (questionList[currentQuestionIndex].options[index] == questionList[currentQuestionIndex].answer) {
                                              // Selected answer and it is correct
                                              return Colors.green;
                                            } else {
                                              // Selected answer and it is wrong
                                              return Colors.red;
                                            }
                                          } else {
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

                                      setState(() {
                                        selectedOption = questionList[currentQuestionIndex].options[index];
                                        shouldRevealAnswer = true; // Set to true to reveal the answer
                                      });

                                      if (questionList[currentQuestionIndex].options[index] == questionList[currentQuestionIndex].answer) {
                                        correctedanswers ++;
                                        print("Correct Answer");
                                      } else {
                                        // Selected answer is wrong
                                        print("Wrong Answer");
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        questionList[currentQuestionIndex].options[index],
                                        style: const TextStyle(
                                          fontSize: 15,
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

                        const SizedBox(height: 20,),
                        currentQuestionIndex + 1 < count
                            ?  SizedBox(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(const Color(0xff494FC7)),
                            ),
                            onPressed: () {


                                setState(() {
                                  layoutType = questionList[currentQuestionIndex]
                                      .options
                                      .any((option) => option.length > 8)
                                      ? true
                                      :false;
                                });
                                print("Totoal Length: " +  layoutType.toString());

                              if(selectedOption == null){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Please Select and answer"),
                                  duration: Duration(milliseconds: 300),
                                ));

                              }
                              else{
                                print( "this is total: " +  count.toString() + "Correct Answers: "  + correctedanswers.toString());
                                setState(() {
                                  shouldRevealAnswer = false; // Reset to false when Next/Done button is pressed
                                  selectedOption = null; // Reset to false when Next/Done button is pressed
                                });

                                if (currentQuestionIndex + 1 < count) {
                                  // Go to the next question
                                  colorSelect();
                                  setState(() {
                                    currentQuestionIndex++;
                                  });
                                } else {
                                  // All questions are done
                                  print("Quiz Completed!");
                                }
                              }

                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            )

                          ),
                        ) :
                        SizedBox(
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(const Color(0xff494FC7)),
                            ),
                            onPressed: () {
                              print( "this is total: " +  count.toString() + " Correct Answers: "  + correctedanswers.toString());
                              print(widget.Id);

                              Map<String , String> data = {
                                "roomId" : widget.roomId!,
                                "userId" : widget.Id!,
                                "totalQuestions" :count.toString(),
                                "userAnswers" :  correctedanswers.toString()
                              };
                              socket.emit("quiz_completed" , data);



                            },
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        )


                      ],
                    );
                  } else {
                    return const SizedBox(); // Return an empty widget if no data is available
                  }
                },
              ),

















            ],
          ),
        ),
      ),
    );
  }

  hello() {}
}


