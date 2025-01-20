import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/quiz/presentation/controllers/quiz_controller.dart';

class ResultsScreen extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text(
          'Quiz Results',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.quiz.value == null) {
          return Center(
            child: Text(
              'No quiz data available',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          );
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.grey[900],
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Quiz Complete!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Final Score: ${controller.score}',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Correct Answers: $correctAnswers / $totalQuestions',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Accuracy: $accuracy%',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Mistakes: ${controller.mistakes}',
                      style: TextStyle(fontSize: 20, color: Colors.redAccent),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        controller.restartQuiz();
                        Get.offAllNamed('/');
                      },
                      child: Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
