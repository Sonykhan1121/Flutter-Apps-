import 'package:codemasterhome/models/question.dart';

class ShortAnswerQuestion extends Question {
  final String modelAnswer;

  ShortAnswerQuestion(String questionText, this.modelAnswer)
      : super(questionText);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer == null) return false;
    // This is a simple implementation; a real app might use more sophisticated
    // text comparison or manual grading
    return userAnswer.toString().trim().toLowerCase().contains(
      modelAnswer.toLowerCase().split(' ')[0],
    );
  }
}