# Quiz App

A Flutter-based application that lets users take quizzes, track scores, and view detailed results. The app utilizes the GetX package for state management and navigation, ensuring a seamless user experience.

---

## Project Overview

The **Quiz App** allows users to:
- Start quizzes from a welcoming Start Quiz page.
- Answer multiple-choice questions in a timed environment.
- View detailed results, including score, accuracy, and mistakes.
- Navigate through the app using an intuitive UI with themes applied.

---

## Features

1. **Start Quiz Page**:
   - Welcome screen with a button to begin the quiz.

2. **Quiz Screen**:
   - Displays questions with multiple-choice answers.
   - Tracks user progress and selected answers.

3. **Results Screen**:
   - Showcases final score, accuracy percentage, and mistakes.
   - Option to restart the quiz.

4. **GetX Integration**:
   - State management and navigation.

5. **Clean UI Design**:
   - A consistent and responsive black theme applied.

---

## Setup Instructions

### Prerequisites
- Install [Flutter SDK](https://docs.flutter.dev/get-started/install).
- Install [Dart SDK](https://dart.dev/get-dart).
- An IDE like [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/).

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo/quiz-app.git
   cd quiz-app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## Dependencies

The following packages are used:
- **GetX**: State management and navigation.
- **flutter_widget_from_html**: Renders HTML content in widgets.

Add these dependencies to `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  get:
  http:
  flutter_widget_from_html:
```

---

## Screenshots and Videos

### Screenshots

#### 1. Start Quiz Page
![Screenshot 2025-01-20 185150](https://github.com/user-attachments/assets/361ae9e9-9e95-4d59-8a9c-2a51f752b180)

#### 2. Quiz Screen
![Screenshot 2025-01-20 185156](https://github.com/user-attachments/assets/e692d915-0c9c-40e9-8c1e-3501384315e3)

#### 3. Results Screen
![Screenshot 2025-01-20 185443](https://github.com/user-attachments/assets/cce1e041-6c29-429c-b53d-db19ad649cb9)

### Video Walkthrough
https://github.com/user-attachments/assets/291357df-32eb-4427-b15f-8e92ffcb8b24

---

## Folder Structure

```
lib/
|- core/
|  |- models/
|      - quiz_model.dart
|  |- network/
|      |- api_provider.dart
|  
|- features/
|  |- quiz/
|      |- data/
|      |- presentation/
|          |- controllers/
|              |- quiz_controller.dart
|          |- screens/
|              |- start_quiz_page.dart
|              |- quiz_screen.dart
|              |- result_screen.dart
|
|- main.dart
```


