import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/network/api_provider.dart';
import 'package:quiz_app/features/quiz/data/quiz_repository.dart';
import 'package:quiz_app/features/quiz/presentation/controllers/quiz_controller.dart';
import 'package:quiz_app/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:quiz_app/features/quiz/presentation/screens/result_screen.dart';
import 'package:quiz_app/features/quiz/presentation/screens/start_quiz_page.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData.dark(),
      initialBinding: BindingsBuilder(() {
        final apiProvider = Get.put(ApiProvider());
        final quizRepository =
            Get.put(QuizRepository(apiProvider: apiProvider));
        Get.put(QuizController(repository: quizRepository));
      }),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => StartQuizScreen()),
        GetPage(name: '/quiz', page: () => QuizScreen()),
        GetPage(name: '/results', page: () => ResultsScreen()),
      ],
    );
  }
}
