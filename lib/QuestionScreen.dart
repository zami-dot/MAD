import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: QuestionScreen(),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _timeLeft = 300;
  int _currentQuestionIndex = 0;
  late List<QuizQuestion> _questions;

  @override
  void initState() {
    super.initState();
    _questions = getQuestionsFromDatabase();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        timer.cancel();
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Time left: ${_timeLeft ~/ 60}:${(_timeLeft % 60).toString().padLeft(2, '0')}'),
      ),
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1617957689233-207e3cd3c610?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cHVycGxlJTIwcGFwZXJ8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Card(
              elevation: 8,
              margin: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                        "Q${_currentQuestionIndex + 1}: ${_questions[_currentQuestionIndex].question}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 20),
                    ..._questions[_currentQuestionIndex]
                        .options
                        .asMap()
                        .entries
                        .map((entry) {
                      int idx = entry.key;
                      String option = entry.value;

                      return ListTile(
                        title: Text(' ${['a', 'b', 'c', 'd'][idx]}: $option',
                            style: TextStyle(fontSize: 16)),
                        onTap: () {
                          setState(() {
                            _currentQuestionIndex =
                                (_currentQuestionIndex + 1) % _questions.length;
                          });
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;

  QuizQuestion({required this.question, required this.options});
}

List<QuizQuestion> getQuestionsFromDatabase() {
  return [
    QuizQuestion(
      question: "Which of the following is used to build UI in Flutter?",
      options: ['Widgets', 'Packages', 'Components', 'Modules'],
    ),
    QuizQuestion(
      question: "What's the primary programming language for Flutter?",
      options: ['Dart', 'JavaScript', 'Kotlin', 'Swift'],
    ),
    QuizQuestion(
      question: "Which widget provides scrollability in Flutter?",
      options: ['ScrollView', 'ListView', 'Scrollable', 'Scroller'],
    ),
    QuizQuestion(
      question: "What's the primary programming language for Flutter?",
      options: ['Dart', 'JavaScript', 'Kotlin', 'Swift'],
    ),
    QuizQuestion(
      question: "Which of the following is NOT a Flutter layout widget?",
      options: ['Column', 'Row', 'Align', 'Compute'],
    ),
    QuizQuestion(
      question:
          "Which widget is used to ensure a consistent visual density in Flutter?",
      options: ['SizedBox', 'MediaQuery', 'VisualDensity', 'Spacer'],
    ),
    QuizQuestion(
      question: "What does the `mainAxisAlignment` property align?",
      options: [
        'Children along the horizontal axis',
        'Children along the vertical axis',
        'Children in the center of the widget',
        'Children to the start of the widget',
      ],
    ),
    QuizQuestion(
      question:
          "Which widget is useful for creating a layered stack of children?",
      options: ['Column', 'Container', 'Stack', 'ListTile'],
    ),
    QuizQuestion(
      question: "What's the key purpose of the `BuildContext` object?",
      options: [
        'To build new widgets',
        'To store the state of a widget',
        'To hold information about the location of a widget in the widget tree',
        'To store theme data for a widget',
      ],
    ),
    QuizQuestion(
      question:
          "Which of the following can you use to manage the state in Flutter?",
      options: ['Provider', 'StatelessWidget', 'BuildContext', 'Scaffold'],
    ),
  ];
}
