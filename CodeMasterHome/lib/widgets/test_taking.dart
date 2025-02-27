import 'package:flutter/material.dart';

import '../models/fillintheblackquestion.dart';
import '../models/matchingquestion.dart';
import '../models/multiple_choice_question.dart';
import '../models/question.dart';
import '../models/shortanswerquestion.dart';
import '../models/truefalsequestion.dart';
import '../utils/appColors.dart';
import '../views/reviewanswerscreen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int _currentQuestionIndex = 0;
  final List<Question> _questions = [
    MultipleChoiceQuestion(
      'What is the capital of France?',
      ['London', 'Paris', 'Berlin', 'Madrid'],
      1,
    ),
    FillInTheBlankQuestion(
      'The boiling point of water is ____ degrees Celsius.',
      '100',
    ),
    TrueFalseQuestion(
      'Flutter is a mobile app development framework created by Google.',
      true,
    ),
    MatchingQuestion(
      'Match the countries with their capitals:',
      ['USA', 'Japan', 'Australia', 'Brazil'],
      ['Washington DC', 'Tokyo', 'Canberra', 'Brasília'],
      [0, 1, 2, 3],
    ),
    ShortAnswerQuestion(
      'Explain the process of photosynthesis in one sentence.',
      'Photosynthesis is the process by which plants convert light energy into chemical energy to fuel their activities.',
    ),
  ];

  List<dynamic> _userAnswers = List.filled(5, null);
  bool _showResults = false;
  final TextEditingController _textController = TextEditingController();

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        if (_questions[_currentQuestionIndex] is FillInTheBlankQuestion ||
            _questions[_currentQuestionIndex] is ShortAnswerQuestion) {
          _textController.clear();
        }
      });
    } else {
      setState(() {
        _showResults = true;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        if (_questions[_currentQuestionIndex] is FillInTheBlankQuestion ||
            _questions[_currentQuestionIndex] is ShortAnswerQuestion) {
          _textController.text = _userAnswers[_currentQuestionIndex] ?? '';
        }
      });
    }
  }

  void _resetTest() {
    setState(() {
      _currentQuestionIndex = 0;
      _userAnswers = List.filled(_questions.length, null);
      _showResults = false;
      _textController.clear();
    });
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_questions[i].checkAnswer(_userAnswers[i])) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Knowledge Test'),
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetTest,
          ),
        ],
      ),
      body: _showResults ? _buildResultsScreen() : _buildQuestionScreen(),
    );
  }

  Widget _buildQuestionScreen() {
    final question = _questions[_currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProgressIndicator(),
          const SizedBox(height: 20),
          _buildQuestionHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: _buildQuestionContent(question),
          ),
          const SizedBox(height: 20),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (_currentQuestionIndex + 1) / _questions.length,
          backgroundColor: Colors.orange.shade50,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
        ),
      ],
    );
  }

  Widget _buildQuestionHeader() {
    final question = _questions[_currentQuestionIndex];
    IconData typeIcon;
    String typeText;

    if (question is MultipleChoiceQuestion) {
      typeIcon = Icons.list;
      typeText = 'Multiple Choice';
    } else if (question is FillInTheBlankQuestion) {
      typeIcon = Icons.text_fields;
      typeText = 'Fill in the Blank';
    } else if (question is TrueFalseQuestion) {
      typeIcon = Icons.check_circle_outline;
      typeText = 'True/False';
    } else if (question is MatchingQuestion) {
      typeIcon = Icons.compare_arrows;
      typeText = 'Matching';
    } else if (question is ShortAnswerQuestion) {
      typeIcon = Icons.short_text;
      typeText = 'Short Answer';
    } else {
      typeIcon = Icons.help_outline;
      typeText = 'Question';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(typeIcon, color: AppColors.secondary),
            const SizedBox(width: 8),
            Text(
              typeText,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          question.questionText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionContent(Question question) {
    if (question is MultipleChoiceQuestion) {
      return _buildMultipleChoiceQuestion(question);
    } else if (question is FillInTheBlankQuestion) {
      return _buildFillInTheBlankQuestion(question);
    } else if (question is TrueFalseQuestion) {
      return _buildTrueFalseQuestion(question);
    } else if (question is MatchingQuestion) {
      return _buildMatchingQuestion(question);
    } else if (question is ShortAnswerQuestion) {
      return _buildShortAnswerQuestion(question);
    }
    return const Text('Unsupported question type');
  }

  Widget _buildMultipleChoiceQuestion(MultipleChoiceQuestion question) {
    return ListView.builder(
      itemCount: question.options.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: RadioListTile<int>(
            title: Text(question.options[index]),
            value: index,
            groupValue: _userAnswers[_currentQuestionIndex],
            onChanged: (value) {
              setState(() {
                _userAnswers[_currentQuestionIndex] = value;
              });
            },
            activeColor: AppColors.secondary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFillInTheBlankQuestion(FillInTheBlankQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: 'Type your answer here',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.orange.shade50,
          ),
          onChanged: (value) {
            setState(() {
              _userAnswers[_currentQuestionIndex] = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTrueFalseQuestion(TrueFalseQuestion question) {
    return Column(
      children: [
        Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: RadioListTile<bool>(
            title: const Text('True'),
            value: true,
            groupValue: _userAnswers[_currentQuestionIndex],
            onChanged: (value) {
              setState(() {
                _userAnswers[_currentQuestionIndex] = value;
              });
            },
            activeColor: AppColors.secondary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: RadioListTile<bool>(
            title: const Text('False'),
            value: false,
            groupValue: _userAnswers[_currentQuestionIndex],
            onChanged: (value) {
              setState(() {
                _userAnswers[_currentQuestionIndex] = value;
              });
            },
            activeColor: AppColors.secondary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchingQuestion(MatchingQuestion question) {
    // Creating a mutable list for the mapping
    List<int?> currentMatching = List<int?>.from(_userAnswers[_currentQuestionIndex] ?? List.filled(question.leftItems.length, null));

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                'Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                'Matches',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: question.leftItems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            question.leftItems[index],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: currentMatching[index],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: [
                          const DropdownMenuItem<int>(
                            value: null,
                            child: Text('Select a match'),
                          ),
                          ...List.generate(
                            question.rightItems.length,
                                (i) => DropdownMenuItem<int>(
                              value: i,
                              child: Text(question.rightItems[i]),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            currentMatching[index] = value;
                            _userAnswers[_currentQuestionIndex] = currentMatching;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShortAnswerQuestion(ShortAnswerQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: 'Type your answer here',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          maxLines: 5,
          onChanged: (value) {
            setState(() {
              _userAnswers[_currentQuestionIndex] = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _currentQuestionIndex > 0 ? _previousQuestion : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back,color: Colors.orange,),
              SizedBox(width: 8),
              Text('Previous'),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _nextQuestion();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_currentQuestionIndex < _questions.length - 1 ? 'Next' : 'Finish'),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward,color: Colors.black,),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultsScreen() {
    final score = _calculateScore();
    final percentage = (score / _questions.length) * 100;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'Test Completed!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score: $score / ${_questions.length}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 20,
                color: percentage >= 70
                    ? Colors.green
                    : percentage >= 50
                    ? Colors.orange
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              onPressed: _resetTest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _showResults = true;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReviewAnswersScreen(questions: _questions, userAnswers: _userAnswers)),
                  );
                });
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Review Answers'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}


