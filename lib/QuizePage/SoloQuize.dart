import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../ApiServices/ApiForGettingQuizes.dart';
import '../ApiServices/ApiServicetoGetMatchDetails.dart';
import '../Models/QuizModels.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SoloQuizPage extends StatefulWidget {
  final String? subcourseName;
  final IO.Socket socket;
  final String? MatchType;
  final String? Id;
  final String? roomId;
  final String? chapterName;
  final String? courseName;

  const SoloQuizPage({
    Key? key,
    this.courseName,
    this.subcourseName,
    this.chapterName,
    this.MatchType,
    this.roomId,
    this.Id, required this.socket,
  }) : super(key: key);

  @override
  State<SoloQuizPage> createState() => _SoloQuizPageState();
}

class _SoloQuizPageState extends State<SoloQuizPage> {
  String donePressed = "";
  String? selectedOption;

  int data = 0;
  int correctedanswers = 0;



  List<QuizQuestion> quizQuestions = [];
  @override
  void initState() {

    super.initState();
    colorSelect();
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


  int totalQ = 0;
  int datacount = 0;



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


  bool shouldRevealAnswer = false;
  int currentQuestionIndex = 0;
  int count = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xff4b99e5),
      body: Column(
        children: [
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
                                // "Question (${currentQuestionIndex + 1}/${questionList.length})",
                                "${ widget. chapterName}",
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
                                         widget. socket.emit("quiz_completed", data);
                                      widget.    socket.on( "quiz_result_announcement",
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
    );
  }

  showresult (dynamic data){
    // if (data["winner"]["id"] ==  id || data["loser"]["id"] == id) {
    //   if (data["winner"]["id"] ==
    //       id)
    //   {
    //     _showWin(data);
    //     ApiServicestogetMatch
    //         .giveResulOftMatch(
    //         "win");
    //   }
    //   else if (data["loser"]
    //   ["name"] ==
    //       name)
    //   {
    //     _showLose(data);
    //     ApiServicestogetMatch
    //         .giveResulOftMatch(
    //         "loss");
    //   }
    // }
    // datacount ++;
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



  hello() {}
}



