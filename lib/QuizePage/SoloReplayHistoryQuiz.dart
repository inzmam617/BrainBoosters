import 'dart:math';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../ApiServices/ApiServicetoGetMatchDetails.dart';
import '../Models/QuizHistoryModel.dart';

class SoloReplayHistoryQuiz extends StatefulWidget {
  final List<dynamic> quizData;
  final String chapterName;

  final IO.Socket socket;

  final String? Id;
  SoloReplayHistoryQuiz({required this.quizData, required this.chapterName, required this.socket,  this.Id,});

  @override
  _SoloReplayHistoryQuizState createState() => _SoloReplayHistoryQuizState();
}

class _SoloReplayHistoryQuizState extends State<SoloReplayHistoryQuiz> {
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool shouldRevealAnswer = false;
  int correctedAnswers = 0;
  List<String> selectedAnswers = [];

  String? completed;
  void checkAnswer(String option) {
    if (shouldRevealAnswer) return; // Don't do anything if the answer is already revealed
    setState(() {
      selectedOption = option;
      shouldRevealAnswer = true; // Set to true to reveal the answer
    });
    selectedAnswers.add(option);
    print(selectedAnswers);
    if (option == widget.quizData[currentQuestionIndex]["answer"]) {
      correctedAnswers++; // Increase the score if the selected answer is correct
      print("Correct Answer");
    } else {
      print("Wrong Answer");
    }

  }
  colorSelect() {
    int randomIndex = Random().nextInt(colorList.length);
    setState(() {
      color = colorList[randomIndex];
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
  void goToNextQuestion() {
    setState(() {
      shouldRevealAnswer = false; // Reset to false when Next/Done button is pressed
      selectedOption = null; // Reset to null when Next/Done button is pressed
      currentQuestionIndex++;
      if (currentQuestionIndex >= widget.quizData.length) {
        print("Quiz Completed!");
      }
    });
  }
  @override
  void initState(){
    super.initState();
    colorSelect();
  }

  @override
  Widget build(BuildContext context) {
    QuizHistoryData questionData = widget.quizData[currentQuestionIndex];
    String question = questionData.question!;
    List<String> options = questionData.options!;
    String answer = questionData.answer!;
    return Scaffold
      (
      backgroundColor: const Color(0xff4b99e5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          // Question Container
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
                      widget.  chapterName,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Center(
                    child: Text(
                      question,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25, top: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                  childAspectRatio: 2.0, // Adjust the aspect ratio as needed
                ),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  String option = options[index];

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 220,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return color;
                          } else if (shouldRevealAnswer) {
                            // Reveal the correct answer
                            if (option == answer) {
                              // Selected answer and it is correct
                              return Colors.green;
                            } else if (option == selectedOption) {
                              // Selected answer and it is wrong
                              return Colors.red;
                            }
                          }
                          return Colors.blue; // Default color
                        }),
                      ),
                      onPressed: () => checkAnswer(option),
                      child: Center(
                        child: Text(
                          option,
                          style: const TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          currentQuestionIndex + 1 < widget.quizData.length
              ? SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50)))),
                backgroundColor: MaterialStateProperty.all(const Color(0xff494FC7)),
              ),
              onPressed: () => goToNextQuestion(),
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
          )
              :  SizedBox(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50)))),
                backgroundColor: MaterialStateProperty.all(const Color(0xff494FC7)),
              ),
              onPressed: () {

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
              child: const Text("Done",style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ),
          )
        ],
      ),
    );
  }
  int correctedanswers = 0;

  int count = 0;

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

}
