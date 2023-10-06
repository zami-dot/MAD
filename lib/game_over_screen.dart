import 'package:flutter/material.dart';
import 'package:Quiz/QuizScreen.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String name;
  GameOverScreen(
      {required this.score, required this.totalQuestions, required this.name});

  @override
  Widget build(BuildContext context) {
    double percentage = (score / totalQuestions) * 100;
    String remarks;
    if (percentage >= 80) {
      remarks = "Excellent!";
    } else if (percentage >= 60) {
      remarks = "Very Good!";
    } else if (percentage >= 40) {
      remarks = "Good Effort!";
    } else {
      remarks = "Better Luck Next Time!";
    }

    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Game Over",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    " $name",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Your Score: $score/$totalQuestions",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Percentage: ${percentage.toStringAsFixed(2)}%",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    remarks,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: percentage >= 60 ? Colors.green : Colors.red,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            userName: name,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Play Again",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
