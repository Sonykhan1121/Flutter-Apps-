import 'package:codemasterhome/models/question.dart';

class FillInTheBlankQuestion extends Question {
  final String correctAnswer;

  FillInTheBlankQuestion(String questionText, this.correctAnswer)
      : super(questionText);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer == null) return false;
    return userAnswer.toString().trim().toLowerCase() ==
        correctAnswer.toLowerCase();
  }
}