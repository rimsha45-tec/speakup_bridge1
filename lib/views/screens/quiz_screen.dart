import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final VoidCallback onQuizComplete;

  QuizScreen({required this.onQuizComplete});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = -1;
  int _score = 0;
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
  String? _selectedOption;

  List<Map<String, dynamic>> _questions = [
    {"question": "What is the synonym of 'Happy'?", "options": ["Sad", "Joyful", "Angry", "Tired"], "answer": "Joyful"},
    {"question": "Choose the correct past tense of 'Go'.", "options": ["Goed", "Went", "Going", "Goes"], "answer": "Went"},
    {"question": "What is the antonym of 'Strong'?", "options": ["Powerful", "Weak", "Tough", "Sturdy"], "answer": "Weak"},
    {"question": "What is the plural of 'Child'?", "options": ["Childs", "Children", "Childes", "Childies"], "answer": "Children"},
    {"question": "Which word is a noun?", "options": ["Run", "Beautiful", "Dog", "Quickly"], "answer": "Dog"},
    {"question": "What is the opposite of 'Cold'?", "options": ["Hot", "Warm", "Chilly", "Cool"], "answer": "Hot"},
    {"question": "Choose the correct article: '___ apple is red.'", "options": ["A", "An", "The", "None"], "answer": "An"},
    {"question": "Identify the verb in: 'She sings beautifully.'", "options": ["She", "Sings", "Beautifully", "The"], "answer": "Sings"},
    {"question": "Which word is an adjective?", "options": ["Run", "Quickly", "Beautiful", "Dog"], "answer": "Beautiful"},
    {"question": "What is the opposite of 'Big'?", "options": ["Small", "Huge", "Large", "Tiny"], "answer": "Small"},
    {"question": "Which of these is a conjunction?", "options": ["However", "Quickly", "Dog", "Slowly"], "answer": "However"},
    {"question": "What is the past tense of 'Eat'?", "options": ["Eaten", "Eats", "Ate", "Eating"], "answer": "Ate"},
    {"question": "Which of these is a preposition?", "options": ["Under", "Quickly", "Dog", "Beautiful"], "answer": "Under"},
    {"question": "Which of these is an adverb?", "options": ["Quick", "Quickly", "Dog", "Happy"], "answer": "Quickly"},
    {"question": "What is the plural of 'Man'?", "options": ["Men", "Manes", "Mans", "Mens"], "answer": "Men"},
  ];

  List<Map<String, String>> _answersReview = []; // To track user responses

  void _startQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _answersReview.clear(); // Reset answers review
    });
  }

  void _nextQuestion() {
    String correctAnswer = _questions[_currentQuestionIndex]['answer'];

    _answersReview.add({
      "question": _questions[_currentQuestionIndex]['question'],
      "userAnswer": _selectedOption ?? "No Answer",
      "correctAnswer": correctAnswer,
    });

    if (_selectedOption == correctAnswer) {
      _score++;
      _correctAnswers++;
    } else {
      _incorrectAnswers++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
      });
    } else {
      setState(() {
        _currentQuestionIndex = -2; // Show result screen
      });
    }
  }

  String _determineUserLevel() {
    double percentage = (_score / _questions.length) * 100;
    if (percentage >= 80) return "Advanced";
    if (percentage >= 50) return "Intermediate";
    return "Beginner";
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex == -1) {
      return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/img.png', height: 150, errorBuilder: (context, error, stackTrace) {
                return Text("Image not found", style: TextStyle(fontSize: 16, color: Colors.red));
              }),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Press Continue to Quiz and Improve Your English",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: _startQuiz,
                child: Text("Continue", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    if (_currentQuestionIndex == -2) {
      return Scaffold(
        backgroundColor: Colors.green.shade100,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Quiz Completed!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                SizedBox(height: 10),
                Text("Correct Answers: $_correctAnswers", style: TextStyle(fontSize: 20, color: Colors.black)),
                Text("Incorrect Answers: $_incorrectAnswers", style: TextStyle(fontSize: 20, color: Colors.black)),
                Text("Your Level: ${_determineUserLevel()}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
                SizedBox(height: 20),
                Text("Review Your Answers:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 10),
                Column(
                  children: _answersReview.map((review) {
                    bool isCorrect = review["userAnswer"] == review["correctAnswer"];
                    return Card(
                      color: isCorrect ? Colors.green.shade100 : Colors.red.shade100,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ListTile(
                        title: Text(review["question"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Your Answer: ${review["userAnswer"]}", style: TextStyle(color: isCorrect ? Colors.green : Colors.red)),
                            Text("Correct Answer: ${review["correctAnswer"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: widget.onQuizComplete,
                  child: Text("Continue to Chatbot", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Column(
              children: _questions[_currentQuestionIndex]['options']
                  .map<Widget>((option) => Card(
                color: Colors.blue.shade50,
                child: RadioListTile(
                  title: Text(option, style: TextStyle(fontSize: 18)),
                  value: option,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as String?;
                    });
                  },
                ),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedOption == null ? null : _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}