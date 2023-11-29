import 'dart:async';
import 'package:atividadedouglas/widgets/xp_indicator.dart';
import 'package:flutter/material.dart';
import 'package:atividadedouglas/models/user.dart';

class QuizScreen extends StatefulWidget {
  final User user;
  final String category;
  final List<Map<String, dynamic>> questions;

  QuizScreen(this.user, this.category, this.questions);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _timerSeconds = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  void _checkAnswer(String selectedOption) {
    _timer.cancel();

    String correctOption = widget.questions[_currentQuestionIndex]['correctOption'];

    if (selectedOption == correctOption) {
      setState(() {
        widget.user.xp += 10;
        widget.user.calculateLevel();
      });
    }

    _nextQuestion();
  }

  void _nextQuestion() {
    _timer.cancel();

    setState(() {
      _timerSeconds = 10;
      if (_currentQuestionIndex < widget.questions.length - 1) {
        _currentQuestionIndex++;
        _startTimer();
      } else {
        _showResultDialog();
      }
    });
  }

  void _resetQuiz() {
    _timer.cancel();

    setState(() {
      _currentQuestionIndex = 0;
      _timerSeconds = 10;
      _startTimer();
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pontuação Final'),
          content: Column(
            children: [
              Text('Você marcou ${widget.user.xp} XP.'),
              Text('Nível: ${widget.user.level}'),
              XpIndicator(widget.user),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Reiniciar'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetQuiz();
              },
            ),
          ],
        );
      },
    ).then((_) {
      Navigator.pop(context, {'xp': widget.user.xp});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App - ${widget.category}'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 16),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Pergunta ${_currentQuestionIndex + 1}/${widget.questions.length}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        widget.questions[_currentQuestionIndex]['question'],
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: widget.questions[_currentQuestionIndex]['options'].map<Widget>((option) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () => _checkAnswer(option),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.all(16),
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child: Text(
                                option,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 16),
                    Text(
                      'Tempo restante: $_timerSeconds segundos',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: XpIndicator(widget.user),
    );
  }
}
