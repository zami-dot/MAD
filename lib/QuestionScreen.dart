import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Quiz/QuizScreen.dart';
import 'package:Quiz/game_over_screen.dart';

var data;

class QuestionScreen extends StatefulWidget {
  const QuestionScreen(
      {super.key, required this.name, required this.num, required this.player});
  final int name;
  final int num;
  final String player;
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _timeLeft = 300;
  int _currentQuestionIndex = 0;
  late List<QuizQuestion> _questions;
  bool _isLoading = true;
  int score = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      _data();
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        timer.cancel();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => GameOverScreen(
                  score: score,
                  totalQuestions: _questions.length,
                  name: widget.player,
                )));
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _data() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference quizDocument = firestore.doc('/quizes/my');
    DocumentSnapshot snapshot = await quizDocument.get();
    setState(() {
      if (snapshot.exists) {
        setState(() {
          data = (snapshot.data() as Map<dynamic, dynamic>)['quizes']
              [widget.num]['quizzes'][widget.name]['questions'];
        });
      }
      _questions = getQuestionsFromDatabase();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
            'Time left: ${_timeLeft ~/ 60}:${(_timeLeft % 60).toString().padLeft(2, '0')}'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => QuizScreen(userName: widget.player)));
            },
            icon: const Icon(Icons.home),
          ),
        ],
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
            child: _isLoading
                ? const CircularProgressIndicator()
                : Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(20),
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 20),
                          ..._questions[_currentQuestionIndex]
                              .options
                              .asMap()
                              .entries
                              .map((entry) {
                            int idx = entry.key;
                            String option = entry.value;
                            String CorrectAnswer =
                                _questions[_currentQuestionIndex].answer;

                            return ListTile(
                              title: Text(
                                  ' ${['a', 'b', 'c', 'd'][idx]}: $option',
                                  style: const TextStyle(fontSize: 16)),
                              onTap: () {
                                if (option == CorrectAnswer) {
                                  setState(() {
                                    score++;
                                  });
                                }
                                if (_currentQuestionIndex ==
                                    _questions.length - 1) {
                                  // If it's the last question, navigate to GameOverScreen
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => GameOverScreen(
                                                score: score,
                                                totalQuestions:
                                                    _questions.length,
                                                name: widget.player,
                                              )));
                                } else {
                                  setState(() {
                                    _currentQuestionIndex =
                                        (_currentQuestionIndex + 1) %
                                            _questions.length;
                                  });
                                }
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
  final dynamic question;
  final List<dynamic> options;
  final dynamic answer;

  QuizQuestion(
      {required this.question, required this.options, required this.answer});
}

List<QuizQuestion> getQuestionsFromDatabase() {
  List<QuizQuestion> questions = [];
  if (data == null) {
    CircularProgressIndicator();
  }
  for (int i = 0; i < 5; i++) {
    questions.add(QuizQuestion(
        question: "${data[i]['question']}",
        options: [
          '${data[i]['options'][0]}',
          '${data[i]['options'][1]}',
          '${data[i]['options'][2]}',
          '${data[i]['options'][3]}'
        ],
        answer: '${data[i]['correctAnswer']}'));
  }

  return questions;
}
