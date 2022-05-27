

class Question {
  final String question, opta, optb, optc, optd;
  final int correctAnswer;
  Question({required this.question,required this.correctAnswer,required this.opta,required this.optb,required this.optc,required this.optd});
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        question: json['question'] as String,
        correctAnswer: (int.tryParse(json['correctanswer'].toString()) == null)
            ? 0
            : int.parse(json['correctanswer'].toString()),
        opta: json['opta'] as String,
        optb: json['optb'] as String,
        optc: json['optc'] as String,
        optd: json['optd'] as String);
  }
  @override
  String toString() { return "Question=" + question + ", Correct Answer=" + correctAnswer.toString();
  }
}

class QuestionsArray {
  final List<dynamic> questionlist;

  QuestionsArray({required this.questionlist});

  factory QuestionsArray.fromJson(Map<String, dynamic> json) {
    return QuestionsArray(questionlist: json['questions'] as List<dynamic>);
  }
}

class QuestionArray {
  static List<Question> questions= [];

}