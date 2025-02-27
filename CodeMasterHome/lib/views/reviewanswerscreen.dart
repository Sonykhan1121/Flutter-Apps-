import 'package:flutter/material.dart';

import '../models/fillintheblackquestion.dart';
import '../models/matchingquestion.dart';
import '../models/multiple_choice_question.dart';
import '../models/question.dart';
import '../models/shortanswerquestion.dart';
import '../models/truefalsequestion.dart';
import '../utils/appColors.dart';


class ReviewAnswersScreen extends StatelessWidget {

  final List<Question> questions;
  final List<dynamic> userAnswers;

  const ReviewAnswersScreen({Key? key, required this.questions, required this.userAnswers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Your Answers', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.secondary,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(questions[index].questionText),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Your Answer: ${_formatAnswer(userAnswers[index], questions[index])}', style: TextStyle(color: pickColors(_formatAnswer(userAnswers[index], questions[index]),_formatCorrectAnswer(questions[index])))),
                  Text('Correct Answer: ${_formatCorrectAnswer(questions[index])}', style: TextStyle(color: Colors.green)),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
  Color pickColors(String a, String b)
  {
    if (a == b) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String _formatAnswer(dynamic answer, Question question) {
    if (question is MultipleChoiceQuestion) {
      print('multi');
      return answer.toString();
    } else if (question is FillInTheBlankQuestion ) {
      print('fillin');
      return answer.toString();
    }
    else if( question is ShortAnswerQuestion)
    {
      print('shortanswer');
      return answer.toString();
    }
    else if (question is TrueFalseQuestion) {
      print('truefalse');
      return answer.toString().toLowerCase();
    } else if (question is MatchingQuestion) {
      print('isMatchingQuestion:');
      return answer.map((int? value) => value == null ? "No match" : question.rightItems[value])
          .join(".");

    }

    return '';
  }

  String _formatCorrectAnswer(Question question) {
    if (question is MultipleChoiceQuestion) {
      print('multi');
      return question.correctAnswer.toString();
    } else if (question is FillInTheBlankQuestion ) {
      print('fillin');
      return question.correctAnswer;
    }
    else if( question is ShortAnswerQuestion)
      {
        print('shortanswer');
        return question.modelAnswer;
      }
    else if (question is TrueFalseQuestion) {
      print('truefalse');
      return question.correctAnswer ? 'true' : 'false';
    } else if (question is MatchingQuestion) {
      print('isMatchingQuestion:');
      return question.correctMatches
          .map((int value) => value == null ? "No match" : question.rightItems[value])
          .join(".");
    }

    return '';
  }
}
