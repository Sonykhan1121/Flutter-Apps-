import 'package:codemasterhome/models/question.dart';

class MatchingQuestion extends Question {
  final List<String> leftItems;
  final List<String> rightItems;
  final List<int> correctMatches;

  MatchingQuestion(
      String questionText,
      this.leftItems,
      this.rightItems,
      this.correctMatches,
      ) : super(questionText);

  @override
  bool checkAnswer(dynamic userAnswer) {
    if (userAnswer == null) return false;

    List<int?> answers = userAnswer as List<int?>;
    if (answers.contains(null)) return false;

    for (int i = 0; i < correctMatches.length; i++) {
      if (answers[i] != correctMatches[i]) {
        return false;
      }
    }
    return true;
  }
}