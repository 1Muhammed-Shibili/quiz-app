import 'package:get/get.dart';
import 'package:quiz_app/core/models/quiz_model.dart';
import 'package:quiz_app/features/quiz/data/quiz_repository.dart';

class QuizController extends GetxController {
  final QuizRepository repository;
  final quiz = Rxn<QuizModel>();
  final currentIndex = 0.obs;
  final score = 0.obs;
  final mistakes = 0.obs;
  final isLoading = true.obs;
  final userAnswers = <int, int>{}.obs;
  final showSolution = false.obs;

  QuizController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    try {
      isLoading.value = true;
      quiz.value = await repository.getQuiz();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load quiz');
    } finally {
      isLoading.value = false;
    }
  }

  void answerQuestion(int optionId) {
    if (currentIndex.value < quiz.value!.questions.length) {
      final question = quiz.value!.questions[currentIndex.value];
      userAnswers[question.id] = optionId;

      final selectedOption =
          question.options.firstWhere((option) => option.id == optionId);

      if (selectedOption.isCorrect) {
        score.value += quiz.value!.correctAnswerMarks.toInt();
      } else {
        score.value -= quiz.value!.negativeMarks.toInt();
        mistakes.value++;
      }

      if (quiz.value!.showAnswers) {
        showSolution.value = true;
        Future.delayed(Duration(seconds: 2), () {
          showSolution.value = false;
          _moveToNext();
        });
      } else {
        _moveToNext();
      }
    }
  }

  void _moveToNext() {
    if (currentIndex.value < quiz.value!.questions.length - 1 &&
        mistakes.value < quiz.value!.questionsCount) {
      currentIndex.value++;
    } else {
      Get.toNamed('/results');
    }
  }

  void restartQuiz() {
    currentIndex.value = 0;
    score.value = 0;
    mistakes.value = 0;
    userAnswers.clear();
    showSolution.value = false;
  }
}
