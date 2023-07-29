import 'package:flutter/material.dart';
import '../ApiServices/ApiServiceForGettingHistoryQuiz.dart';
import '../Models/QuizHistoryModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../QuizePage/QuizePage.dart';
import '../QuizePage/SoloReplayHistoryQuiz.dart';
import '../const.dart';

class QuizHistoryScreen extends StatefulWidget {
  @override
  State<QuizHistoryScreen> createState() => _QuizHistoryScreenState();
}

class _QuizHistoryScreenState extends State<QuizHistoryScreen> {
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
  @override
  void initState(){
    super.initState();
    connectToServer();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff494FC7),
        title: const Text('Quiz History'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<QuizHistoryResponse>>(
            future: QuizAPIFOr.getQuizResponses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<QuizHistoryResponse>? quizResponses = snapshot.data;
                if (quizResponses == null || quizResponses.isEmpty) {
                  return const Center(child: Text('No quiz responses available.'));
                } else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                        itemCount: quizResponses.length,
                        itemBuilder: (context, index) {
                          final quizResponse = quizResponses[index];
                          return InkWell(
                            onTap: () {
                              // printQuizHistoryData(quizResponse.data);
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                                return QuizPage(  MatchType: "historyReplay", quizData: [...?quizResponse.data],chapterName: 'SOMETHINGS');
                                  // SoloReplayHistoryQuiz(  quizData: [...quizResponse.data!]// Use the spread operator here
                                  // , chapterName: 'SOMETHINGS', socket:socket ,);

                              }));

                            },
                            child: ListTile(
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.play_circle, color: Colors.purple),
                              ),
                              title: Text('Result: ${quizResponse.result}'),
                              subtitle: Text('Corrected Answers: ${quizResponse.correctedAnswers}'),
                              // Add more details as needed...
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  void printQuizHistoryData(List<QuizHistoryData>? quizData) {
    if (quizData != null && quizData.isNotEmpty) {
      for (var data in quizData) {
        print('Question: ${data.question}');
        print('Options: ${data.options}');
        print('Answer: ${data.answer}');
      }
    }
  }
}
