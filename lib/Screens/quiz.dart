import 'package:flutter/material.dart';

import '../Utiles/Utilities.dart';
import '../Widgets/drawer.dart';
import '../data/source/question.dart';
import '../main.dart';


class VSJQuizApp12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 90,
              shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(16)),
              backgroundColor:const Color(0xFF141D41),
              title:const Text(
                  "Quiz",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 3,
                    backgroundColor:  Color(0xFF141D41),
                    fontSize: 30,
                  )),
              centerTitle: true,
            ),
            backgroundColor:const Color(0xFF1C2341),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Vsjthree(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Vsjthree extends StatefulWidget {
  final TextStyle radiostyle = const TextStyle(color: Colors.white);
  @override
  _VSJQuizState createState() => _VSJQuizState();
}

class _VSJQuizState extends State<Vsjthree> {
  bool isvisible = false;
  String buttonstart = "Start";
  String currentquestiontext = "Welcome To Programming Quiz";
  String opta = "A", optb = "B", optc = "C", optd = "D";
  int questionno = -1;
  int correctanswers = 0;
  bool isTestOver = false;
  List<Question> questions = QuestionArray.questions;
  Question? currentquestion;
  List<Widget> scoresone = [], scorestwo = [];
  List<String> answeroptions = [
    "Varanasi",
    "Lucknow",
    "Chiraigaon",
    "Hukulganj"
  ];
  int _result = 1;
  void gotohome() {
    Navigator.pushNamed(context, '/');
  }

  void setQuestion(int b, BuildContext context) async {
    if (isTestOver) return;
    if (questionno == -1) {
      _result = 0;
      buttonstart = "Submit";

      isvisible = false;
      isvisible = true;

      questions = Utilities.questionlist;
      questionno++;
      currentquestion = questions[questionno];
      currentquestiontext = currentquestion!.question;
      opta = currentquestion!.opta;
      optb = currentquestion!.optb;
      optc = currentquestion!.optc;
      optd = currentquestion!.optd;
      setState(() {});
      return;
    }
    if (currentquestion!.correctAnswer != currentquestion!.correctAnswer) {
      print("$correctanswers");
    }

    if (questionno >= questions.length - 1) {
      addResult(b);

      currentquestiontext = "Questions Over. Correct answers = $correctanswers";
      Utilitiess().show(context, currentquestiontext);
      isTestOver = true;
      isvisible = false;
      buttonstart = "Home";
      return;
    }

    addResult(_result);

    questionno++;

    if (questionno <= questions.length - 1) {
      currentquestion = questions[questionno];
      currentquestiontext = currentquestion!.question;
      opta = currentquestion!.opta;
      optb = currentquestion!.optb;
      optc = currentquestion!.optc;
      optd = currentquestion!.optd;
    }
  }

  void addResult(int answer) {
    bool iscorrect = (answer == currentquestion!.correctAnswer);
    print("Submitted " +
        answer.toString() +
        "  " +
        currentquestion!.correctAnswer.toString());
    int n = scoresone.length;
    print(n);
    print(scorestwo.length);
    if (iscorrect) {
      correctanswers++;
      if (n < 17) {
        scoresone.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scorestwo.add(const Icon(Icons.check, color: Colors.green));
      }
    } else {
      if (n < 17) {
        scoresone.add(const Icon(Icons.close, color: Colors.red));
      } else {
        scorestwo.add(const Icon(Icons.check, color: Colors.red));
      }
    }
    _result = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                currentquestiontext,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        //***************************************************************

        Expanded(
          flex: 5,
          child: Column(
            children: [
              //*****************************888888888888888888
              Expanded(
                child: Visibility(
                  visible: isvisible,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile<int?>(
                          title: Text(
                            opta,
                            style: widget.radiostyle,
                          ),
                          value: 1,
                          groupValue: _result,
                          onChanged: (int? value) {
                            setState(() {
                              _result = 1;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<int?>(
                          title: Text(
                            optb,
                            style: widget.radiostyle,
                          ),
                          value: 2,
                          groupValue: _result,
                          onChanged: (int? value) {
                            setState(() {
                              _result = 2;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //******************88888888888888888888888888
              //*****************************888888888888888888
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Visibility(
                        visible: isvisible,
                        child: RadioListTile<int?>(
                          title: Text(
                            optc,
                            style: widget.radiostyle,
                          ),
                          value: 3,
                          groupValue: _result,
                          onChanged: (int? value) {
                            setState(() {
                              _result = 3;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                        visible: isvisible,
                        child: RadioListTile<int?>(
                          title: Text(
                            optd,
                            style: widget.radiostyle,
                          ),
                          value: 4,
                          groupValue: _result,
                          onChanged: (int? value) {
                            setState(() {
                              _result = 4;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //******************88888888888888888888888888
            ],
          ),
        ),

        //****************************************************************

        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  primary: Colors.green,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text(
                  buttonstart,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  if (isTestOver != true) {
                    if (_result == 0) {
                      Utilitiess().show(context,
                          "Select the option after that Click on Submit");
                    }
                    if (_result != 0) {
                      print("Submitted True");
                      setState(() {
                        // addResult(true);
                        setQuestion(_result, context);
                      });
                    }
                  } else {
                    gotohome( );
                  }
                }),
          ),
        ),
        Expanded(
          child: Column(children: [
            Expanded(child: Row(children: scoresone)),
            Expanded(child: Row(children: scorestwo)),
          ]),
        ),
      ],
    );
  }
}






