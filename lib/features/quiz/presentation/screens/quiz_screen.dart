import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/quiz/presentation/controllers/quiz_controller.dart';

class QuizScreen extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.quiz.value?.title ?? 'Quiz')),
        actions: [
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Score: ${controller.score}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ))
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.quiz.value == null) {
          return Center(child: Text('No quiz available'));
        }

        final question =
            controller.quiz.value!.questions![controller.currentIndex.value];

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: (controller.currentIndex.value + 1) /
                      controller.quiz.value!.questions!.length,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${controller.currentIndex.value + 1}/${controller.quiz.value!.questions!.length}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Mistakes: ${controller.mistakes}/${controller.quiz.value!.questions!.length}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.description ?? '',
                          style: TextStyle(fontSize: 20),
                        ),
                        if (question.readingMaterial != null) ...[
                          SizedBox(height: 16),
                          ExpansionTile(
                            title: Text('Reading Material'),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(question
                                    .readingMaterial!.contentSections
                                    .join('\n')),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ...question.options!.map((option) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          backgroundColor: controller.showSolution.value
                              ? option.isCorrect!
                                  ? Colors.green
                                  : controller.userAnswers[question.id] ==
                                          option.id
                                      ? Colors.red
                                      : null
                              : null,
                        ),
                        onPressed: controller.showSolution.value
                            ? null
                            : () => controller.answerQuestion(option.id!),
                        child: Text(
                          option.description ?? '',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )),
                if (controller.showSolution.value) ...[
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Solution',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(question.detailedSolution ?? ''),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
