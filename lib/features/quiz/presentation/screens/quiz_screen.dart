import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/quiz/presentation/controllers/quiz_controller.dart';

class QuizScreen extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Obx(() => Text(
              controller.quiz.value?.title ?? 'Quiz',
              style: TextStyle(color: Colors.white),
            )),
        actions: [
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Score: ${controller.score}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ))
        ],
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.quiz.value == null) {
          return Center(
              child: Text('No quiz available',
                  style: TextStyle(color: Colors.white)));
        }

        final question =
            controller.quiz.value!.questions[controller.currentIndex.value];

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: (controller.currentIndex.value + 1) /
                      controller.quiz.value!.questions.length,
                  color: Colors.cyanAccent,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${controller.currentIndex.value + 1}/${controller.quiz.value!.questions.length}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'Mistakes: ${controller.mistakes}/${controller.quiz.value!.questions.length}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.grey[800],
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.description,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        if (question.readingMaterial != null) ...[
                          SizedBox(height: 16),
                          ExpansionTile(
                            title: Text(
                              'Reading Material',
                              style: TextStyle(color: Colors.white),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: HtmlWidget(
                                  question.readingMaterial!.contentSections
                                      .join('\n'),
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ...question.options.map((option) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          backgroundColor: controller.showSolution.value
                              ? option.isCorrect
                                  ? Colors.green
                                  : controller.userAnswers[question.id] ==
                                          option.id
                                      ? Colors.red
                                      : Colors.grey[800]
                              : Colors.blueGrey[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: controller.showSolution.value
                            ? null
                            : () => controller.answerQuestion(option.id),
                        child: Text(
                          option.description,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    )),
                if (controller.showSolution.value) ...[
                  SizedBox(height: 20),
                  Card(
                    color: Colors.grey[800],
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
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          HtmlWidget(
                            question.detailedSolution,
                            textStyle: TextStyle(color: Colors.white70),
                          ),
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
