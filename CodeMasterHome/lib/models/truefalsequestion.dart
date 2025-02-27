import 'package:codemasterhome/models/question.dart';

class TrueFalseQuestion extends Question {
  final bool correctAnswer;

  TrueFalseQuestion(String questionText, this.correctAnswer)
      : super(questionText);

  @override
  bool checkAnswer(dynamic userAnswer) {
    return userAnswer == correctAnswer;
  }
}
