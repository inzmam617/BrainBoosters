// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
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
//
//
// Future<List<Question>> fetchQuestions() async {
//   final response = await http.get(Uri.parse('http://localhost:3000/questions'));
//
//   if (response.statusCode == 200) {
//     final jsonResponse = jsonDecode(response.body);
//     return List<Question>.from(jsonResponse.map((data) {
//       final List<Answer> answersList = List<Answer>.from(data['answersList'].map((answer) => Answer(answer['answerText'], answer['isCorrect'])));
//       return Question(data['questionText'], answersList);
//     }));
//   } else {
//     throw Exception('Failed to fetch questions');
//   }
// }
// List<Question> questions = await fetchQuestions();
//
// // List<Question> getQuestions() {
// //   List<Question> list = [];
// //   //ADD questions and answer here
// //
// //   list.add(Question(
// //     "Who is the owner of Flutter?",
// //     [
// //       Answer("Nokia", false),
// //       Answer("Samsung", false),
// //       Answer("Google", true),
// //       Answer("Apple", false),
// //     ],
// //   ));
// //
// //   list.add(Question(
// //     "Who owns Iphone?",
// //     [
// //       Answer("Apple", true),
// //       Answer("Microsoft", false),
// //       Answer("Google", false),
// //       Answer("Nokia", false),
// //     ],
// //   ));
// //
// //   list.add(Question(
// //     "Youtube is _________  platform?",
// //     [
// //       Answer("Music Sharing", false),
// //       Answer("Video Sharing", false),
// //       Answer("Live Streaming", false),
// //       Answer("All of the above", true),
// //     ],
// //   ));
// //
// //   list.add(Question(
// //     "Flutter user dart as a language?",
// //     [
// //       Answer("True", true),
// //       Answer("False", false),
// //       Answer("Maybe", false),
// //       Answer("No Sure", false),
// //     ],
// //   ));
// //
// //   return list;
// // }