class QuizQuestion {
  String question;
  List<String> options;
  String answer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}
class Answer {
  String answerText;
  bool isCorrect;

  Answer({
    required this.answerText,
    required this.isCorrect,
  });
}