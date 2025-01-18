import 'dart:developer' as developer;
import 'package:quiz_app/core/models/quiz_model.dart';
import 'package:quiz_app/core/network/api_provider.dart';

class QuizRepository {
  final ApiProvider apiProvider;

  QuizRepository({required this.apiProvider});

  Future<QuizModel> getQuiz() async {
    try {
      developer.log('Fetching quiz data from repository');
      final data = await apiProvider.getQuizData();
      developer.log('Successfully received quiz data');
      return QuizModel.fromJson(data);
    } catch (e) {
      developer.log('Error in getQuiz: $e');
      throw Exception('Failed to load quiz: $e');
    }
  }
}
