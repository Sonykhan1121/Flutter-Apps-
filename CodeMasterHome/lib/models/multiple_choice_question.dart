import 'package:codemasterhome/models/question.dart';

class MultipleChoiceQuestion extends Question {
  final List<String> options;
  final int correctAnswer;

  MultipleChoiceQuestion(String questionText, this.options, this.correctAnswer)
      : super(questionText);

  @override
  bool checkAnswer(dynamic userAnswer) {
    return userAnswer == correctAnswer;
  }
}