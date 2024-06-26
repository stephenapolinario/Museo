import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/models/quiz.dart';

class BuildQuestionCount extends StatelessWidget {
  const BuildQuestionCount({
    super.key,
    required int questionNumber,
    required this.quiz,
  }) : _questionNumber = questionNumber;

  final int _questionNumber;
  final NewQuiz quiz;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16),
      child: Text(
        '${context.loc.question} $_questionNumber/${quiz.questions.length}',
        style: const TextStyle(
          color: mainBlue,
          fontSize: 22,
        ),
      ),
    );
  }
}
