import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiServices/ApiForGettingQuizes.dart';
import '../ApiServices/ApiServicetoGetMatchDetails.dart';
import '../Models/QuizModels.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../const.dart';

class QuizPage extends StatefulWidget {
  final String? subcourseName;
  final String? MatchType;
  final String? Id;
  final String? roomId;
  final String? chapterName;
  final String? courseName;

  const QuizPage({
    Key? key,
    this.courseName,
    this.subcourseName,
    this.chapterName,
    this.MatchType,
    this.roomId,
    this.Id,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String donePressed = "";
  String? selectedOption;
  bool layoutType = false;
  late IO.Socket socket;

  void connectToServer() {
    try {
      print("starting");
      socket = IO.io(
          baseUrl,
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      socket.connect();
    } catch (e) {
      print(e.toString());
    }
  }
  int data = 0;

  int correctedanswers = 0;
  Timer? _timer;
  int _seconds = 30;
  late ConfettiController _confettiController;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  List<QuizQuestion> quizQuestions = [];
  String? name;
  String? email;
  String? id;

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name").toString();
      id = prefs.getString("id").toString();
      email = prefs.getString("email").toString();
    });
  }

  @override
  void initState() {
    print("Something");
    connectToServer();
    initialize();

    super.initState();
    colorSelect();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
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
        loopMode: LoopMode.single);
  }

  StreamController<List<QuizQuestion>> quizQuestionsController =
      StreamController<List<QuizQuestion>>();

  Future<List<QuizQuestion>>? loadQuizQuestions() async {
    try {
      if (count == 0) {
        if (widget.subcourseName == null) {
          quizQuestions = await QuizApiService.getQuizQuestions(
            (widget.courseName!).toString(),
            (widget.courseName!).toString(),
            (widget.chapterName!).toString(),
          );
        } else {
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
    return [];
  }

  colorSelect() {
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

  int totalQ = 0;
  int datacount = 0;

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
          print("object");

          if (widget.MatchType == "solo") {
            soloFinish();
          } else {
            Onev1finish();
          }

          // _showTimeUpDialog(); // Show dialog when the timer reaches zero
        }
      });
    });
  }

  void soloFinish() {
    print("Solo cAlculating");
    print(totalQ);
    print(correctedanswers);
    bool didWin = didWinQuiz(totalQ, correctedanswers);
    print(didWin);
    if (didWin) {
      print("win");
      ApiServicestogetMatch.giveResulOftMatch("win");
      _showResult("Won", totalQ.toString(), correctedanswers.toString());
    } else {
      print("Lost");

      ApiServicestogetMatch.giveResulOftMatch("loss");
      _showResult("Lost", totalQ.toString(), correctedanswers.toString());
    }
  }

  void Onev1finish() {
    Map<String, String> data = {
      "roomId": widget.roomId!,
      "userId": widget.Id!,
      "totalQuestions": count.toString(),
      "userAnswers": correctedanswers.toString(),
    };
    socket.emit("quiz_completed", data);
    socket.on("quiz_result_announcement", (data) {
      print(data);
      if (data["winner"]["id"] == id || data["loser"]["id"] == id) {
        if (data["winner"]["id"] == id) {
          _showWin(data);
          ApiServicestogetMatch.giveResulOftMatch("win");
        } else if (data["loser"]["name"] == name) {
          _showLose(data);
          ApiServicestogetMatch.giveResulOftMatch("loss");
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Time's Up"),
        duration: Duration(milliseconds: 300),
      ),
    );
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

  Future<void> _showAlertDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Confirm'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to Leave Quiz?'),
                Text('If you Leave you will loose the mach!'),
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
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff494FC7))),
                    child: const Text('Yes'),
                    onPressed: () {
                      if (widget.MatchType == "solo") {
                        soloFinish();
                      } else {
                        Onev1finish();
                      }
                      _assetsAudioPlayer.stop();
                      Get.back();
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.black),
                    ),
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
                  color: Colors.white,
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
                  color: Colors.white,
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
                        color: Colors.black,
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
                  color: Colors.white,
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
                        color: Colors.black,
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
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff494FC7)),
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
                  child:
                      const Text('Back', style: TextStyle(color: Colors.black)),
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
  List<String> menuItems = ['Exit', 'Music'];

  void _showDialog(BuildContext context, String selectedItem) {
    switch (selectedItem) {
      case 'Exit':
        _showAlertDialog();
        break;
      case 'Music':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return showAlertDialogForMusic();
          },
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cant leave during Quiz"),
            duration: Duration(seconds: 1),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xff3e44b8),
        // backgroundColor: const Color(0xff4b99e5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name.toString().toUpperCase() ?? "",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset("assets/q.svg",height: 65,width: 65,),

                    Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       SvgPicture.asset("assets/earth-svgrepo-com.svg",height: 40,width: 40,),

                        PopupMenuButton<String>(
                          onSelected: (String selectedItem) {
                            _showDialog(context, selectedItem);
                          },
                          itemBuilder: (BuildContext context) {
                            return menuItems.map((String item) {
                              return PopupMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList();
                          },
                          icon: const Icon(Icons.more_vert,
                              color: Colors.white, size: 30),
                        ),
                     ],
                   )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Color(0xff2b31a7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Color(0xff2b31a7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Color(0xff2b31a7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                      ],
                    ),
                    Container(
                      height: 25,
                      width: 80,
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
                            Text(
                              "${_formatDuration(Duration(seconds: _seconds))} sec",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Color(0xff2b31a7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Color(0xff2b31a7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Color(0xff2b31a7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Match Type : ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.MatchType!.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<QuizQuestion>>(
                future: count == 0 ? loadQuizQuestions() : hello(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Please wait while your quiz's are loading..",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    count == 0 ? _startTimer() : hello();
                    List<QuizQuestion> questionList = snapshot.data!;
                    count = questionList.length;
                    totalQ = questionList.length;

                    return Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 3.5)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, blurRadius: 3.5)
                                  ],
                                  color: Color(0xff3e44b8),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 30,
                                child: Center(
                                  child: Text(
                                    "Question (${currentQuestionIndex + 1}/${questionList.length})",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 35),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                                child: Center(
                                  child: Text(
                                    questionList[currentQuestionIndex].question,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 25, left: 25, right: 25, top: 10),
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
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 20,
                                childAspectRatio:
                                    2.0, // Adjust the aspect ratio as needed
                              ),
                              itemCount: questionList[currentQuestionIndex]
                                  .options
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                String answer =
                                    questionList[currentQuestionIndex].answer;

                                return SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.5, // Adjust the width as needed
                                  height: 220, // Adjust the height as needed
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            // Button is pressed
                                            return color;
                                          } else if (shouldRevealAnswer) {
                                            // Reveal the correct answer
                                            if (questionList[
                                                        currentQuestionIndex]
                                                    .options[index] ==
                                                questionList[
                                                        currentQuestionIndex]
                                                    .answer) {
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
                                    onPressed: () async {
                                      if (questionList[currentQuestionIndex]
                                              .options[index]
                                              .toString() ==
                                          questionList[currentQuestionIndex]
                                              .answer
                                              .toString()) {}
                                      setState(() {
                                        selectedOption =
                                            questionList[currentQuestionIndex]
                                                .options[index];
                                        shouldRevealAnswer =
                                            true; // Set to true to reveal the answer
                                      });
                                      if (questionList[currentQuestionIndex]
                                              .options[index] ==
                                          questionList[currentQuestionIndex]
                                              .answer) {
                                        correctedanswers++;
                                        print("Correct Answer");
                                      } else {
                                        // Selected answer is wrong
                                        print("Wrong Answer");
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        questionList[currentQuestionIndex]
                                            .options[index],
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
                        const SizedBox(
                          height: 20,
                        ),
                        currentQuestionIndex + 1 < count
                            ? SizedBox(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff494FC7)),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        layoutType =
                                            questionList[currentQuestionIndex]
                                                    .options
                                                    .any((option) =>
                                                        option.length > 8)
                                                ? true
                                                : false;
                                      });
                                      if (selectedOption == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text("Please Select and answer"),
                                          duration: Duration(milliseconds: 300),
                                        ));
                                      } else {
                                        setState(() {
                                          shouldRevealAnswer =
                                              false; // Reset to false when Next/Done button is pressed
                                          selectedOption =
                                              null; // Reset to false when Next/Done button is pressed
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
                                    )),
                              )
                            : donePressed == ""
                                ? widget.MatchType == "solo"
                                    ? SizedBox(
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xff494FC7)),
                                          ),
                                          onPressed: () {
                                            //this is for solo player
                                            setState(() {
                                              donePressed = "press";
                                            });
                                            int totalQuestions = count;
                                            int correctAnswers =
                                                correctedanswers;

                                            bool didWin = didWinQuiz(
                                                totalQuestions, correctAnswers);

                                            if (didWin) {
                                              ApiServicestogetMatch
                                                  .giveResulOftMatch("win");
                                              _showResult(
                                                  "Won",
                                                  count.toString(),
                                                  correctedanswers.toString());
                                            } else {
                                              ApiServicestogetMatch
                                                  .giveResulOftMatch("loss");
                                              _showResult(
                                                  "Lost",
                                                  count.toString(),
                                                  correctedanswers.toString());
                                            }
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
                                    : SizedBox(
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xff494FC7)),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              donePressed = "press";
                                            });
                                            Map<String, String> data = {
                                              "roomId": widget.roomId!,
                                              "userId": widget.Id!,
                                              "totalQuestions": count.toString(),
                                              "userAnswers":  correctedanswers.toString()
                                            };
                                            socket.emit("quiz_completed", data);
                                            socket.on( "quiz_result_announcement",
                                                (data) => {
                                                datacount ==  0   ?    showresult(data):hello()
                                                    });
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
                                :   widget.MatchType == "solo"
                            ? SizedBox() :  const SizedBox(
                                    child: Text(
                                      "Please wait other user is still playing...",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
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
  showresult (dynamic data){
    if (data["winner"]["id"] ==  id || data["loser"]["id"] == id) {
      if (data["winner"]["id"] ==
          id)
      {
        _showWin(data);
    ApiServicestogetMatch
        .giveResulOftMatch(
    "win");
    }
    else if (data["loser"]
    ["name"] ==
    name)
    {
    _showLose(data);
    ApiServicestogetMatch
        .giveResulOftMatch(
    "loss");
    }
  }
    datacount ++;
  }

  bool didWinQuiz(int totalQuestions, int correctAnswers) {
    double percentageCorrect =
        (correctAnswers.toDouble() / totalQuestions) * 100;
    return percentageCorrect >= 70;
  }

  Future<void> _showResult(String a, String total, String correct) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Match Result'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You $a',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Total Questions:  $total!',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Correct Answers:  $correct!',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showWin(dynamic a) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text(
                  'You Win!',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text('Winner:   ${a["winner"]["name"]}'),
                Text('Looser" ${a["loser"]["name"]}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLose(dynamic a) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text(
                  'You Loose!',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text('Winner:   ${a["winner"]["name"]}'),
                Text('Looser" ${a["loser"]["name"]}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  hello() {}
}
