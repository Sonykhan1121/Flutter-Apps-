abstract class Question {
  final String questionText;

  Question(this.questionText);

  bool checkAnswer(dynamic userAnswer);
}
