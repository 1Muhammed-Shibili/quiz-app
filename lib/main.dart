import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/network/api_provider.dart';
import 'package:quiz_app/features/quiz/data/quiz_repository.dart';
import 'package:quiz_app/features/quiz/presentation/controllers/quiz_controller.dart';
import 'package:quiz_app/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:quiz_app/features/quiz/presentation/screens/result_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: BindingsBuilder(() {
        // Initialize ApiProvider
        final apiProvider = Get.put(ApiProvider());

        // Initialize Repository with ApiProvider
        final quizRepository =
            Get.put(QuizRepository(apiProvider: apiProvider));

        // Initialize Controller with Repository
        Get.put(QuizController(repository: quizRepository));
      }),
      getPages: [
        GetPage(name: '/', page: () => QuizScreen()),
        GetPage(name: '/results', page: () => ResultsScreen()),
      ],
    );
  }
}
