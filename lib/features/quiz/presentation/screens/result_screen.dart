import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/quiz/presentation/controllers/quiz_controller.dart';

class ResultsScreen extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Results')),
      body: Obx(() {
        if (controller.quiz.value == null) {
          return Center(child: Text('No quiz data available'));
        }

        final quiz = controller.quiz.value!;
        final totalQuestions = quiz.questions.length;
        final correctAnswers = controller.userAnswers.entries.where((entry) {
          final question = quiz.questions.firstWhere(
            (q) => q.id == entry.key,
            orElse: () => throw Exception('Question not found'),
          );
          final correctOption = question.options.firstWhere(
            (opt) => opt.isCorrect,
            orElse: () => throw Exception('No correct option found'),
          );
          return entry.value == correctOption.id;
        }).length;

        final accuracy = totalQuestions > 0
            ? (correctAnswers / totalQuestions * 100).toStringAsFixed(1)
            : '0';

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Complete!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Final Score: ${controller.score}',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 10),
              Text(
                'Correct Answers: $correctAnswers / $totalQuestions',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Accuracy: $accuracy%',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Total Mistakes: ${controller.mistakes}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: () {
                  controller.restartQuiz();
                  Get.offAllNamed('/');
                },
                child: Text(
                  'Try Again',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
