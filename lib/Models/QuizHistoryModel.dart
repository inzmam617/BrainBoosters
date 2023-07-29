class QuizHistoryResponse {
  final String? id;
  final String? studentId;
  final List<QuizHistoryData>? data;
  final int? correctedAnswers;
  final List<String>? selectedAnswers;
  final int? totalQuestions;
  final String? result;

  QuizHistoryResponse({
    this.id,
    this.studentId,
    this.data,
    this.correctedAnswers,
    this.selectedAnswers,
    this.totalQuestions,
    this.result,
  });

  factory QuizHistoryResponse.fromJson(Map<String, dynamic> json) {
    // Extract the nested 'data' field from the JSON response
    final dataField = json['data'];
    List<QuizHistoryData>? quizData;

    // Check the type of 'dataField'
    if (dataField is List) {
      // If 'dataField' is a list, then parse it as a list of QuizHistoryData
      quizData = List<QuizHistoryData>.from(dataField.map((data) => QuizHistoryData.fromJson(data)));
    } else if (dataField is String) {
      // If 'dataField' is a string, then parse it as a single QuizHistoryData object
      quizData = [QuizHistoryData.fromJson(json['data'])];
    } else {
      // Handle other cases if necessary
    }

    return QuizHistoryResponse(
      id: json['_id'],
      studentId: json['studentId'],
      data: quizData,
      correctedAnswers: json['correctedAnswers'],
      selectedAnswers: List<String>.from(json['selectedAnswers']),
      totalQuestions: json['totalQuestions'],
      result: json['result'],
    );
  }
}



class QuizHistoryData {
  final String? question;
  final List<String>? options;
  final String? answer;

  QuizHistoryData({
     this.question,
     this.options,
     this.answer,
  });

  factory QuizHistoryData.fromJson(Map<String, dynamic> json) {
    return QuizHistoryData(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}