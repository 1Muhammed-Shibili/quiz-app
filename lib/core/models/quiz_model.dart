import 'dart:convert';

class QuizModel {
  final int id;
  final String title;
  final String description;
  final String topic;
  final DateTime? time;
  final int duration;
  final double negativeMarks;
  final double correctAnswerMarks;
  final bool shuffle;
  final bool showAnswers;
  final int questionsCount;
  final List<Question> questions;

  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.topic,
    this.time,
    required this.duration,
    required this.negativeMarks,
    required this.correctAnswerMarks,
    required this.shuffle,
    required this.showAnswers,
    required this.questionsCount,
    required this.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      topic: json['topic'] ?? '',
      time: json['time'] != null ? DateTime.parse(json['time']) : null,
      duration: json['duration'] ?? 0,
      negativeMarks: double.tryParse(json['negative_marks'] ?? '0') ?? 0.0,
      correctAnswerMarks:
          double.tryParse(json['correct_answer_marks'] ?? '0') ?? 0.0,
      shuffle: json['shuffle'] ?? false,
      showAnswers: json['show_answers'] ?? false,
      questionsCount: json['questions_count'] ?? 0,
      questions: (json['questions'] as List? ?? [])
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String description;
  final String topic;
  final String detailedSolution;
  final List<Option> options;
  final ReadingMaterial? readingMaterial; // Added this back

  Question({
    required this.id,
    required this.description,
    required this.topic,
    required this.detailedSolution,
    required this.options,
    this.readingMaterial, // Added to constructor
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      topic: json['topic'] ?? '',
      detailedSolution: json['detailed_solution'] ?? '',
      options: (json['options'] as List? ?? [])
          .map((o) => Option.fromJson(o))
          .toList(),
      readingMaterial: json['reading_material'] != null
          ? ReadingMaterial.fromJson(json['reading_material'])
          : null,
    );
  }
}

class ReadingMaterial {
  final int id;
  final List<String> keywords;
  final List<String> contentSections;

  ReadingMaterial({
    required this.id,
    required this.keywords,
    required this.contentSections,
  });

  factory ReadingMaterial.fromJson(Map<String, dynamic> json) {
    List<String> parseKeywords(dynamic keywords) {
      if (keywords == null) return [];
      if (keywords is String) {
        try {
          final decoded = jsonDecode(keywords);
          if (decoded is List) {
            return decoded.map((e) => e.toString()).toList();
          }
        } catch (e) {
          // If parsing fails, return empty list
          return [];
        }
      }
      if (keywords is List) {
        return keywords.map((e) => e.toString()).toList();
      }
      return [];
    }

    return ReadingMaterial(
      id: json['id'] ?? 0,
      keywords: parseKeywords(json['keywords']),
      contentSections: (json['content_sections'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

class Option {
  final int id;
  final String description;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}
