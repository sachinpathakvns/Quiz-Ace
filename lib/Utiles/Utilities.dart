import 'package:flutter/material.dart';
import '../Screens/levels.dart';
import '../Screens/quizlist.dart';
import '../data/source/question.dart';
import '../main.dart';

class Utilities {
  static List<Question> questionlist = [];
  static List<Levels> quizlevels = [];
  static List<QuizList> quizzeslist = [];
  static get question => null;
  static List<Widget> getButtons() {
    List<Widget> buttons = [];
    for (QuizList q in quizzeslist) {
      buttons.add(q.getButton());
    }
    return buttons;
  }

  static List<Widget> getLevelButtons() {
    List<Widget> buttons = [];
    for (Levels q in quizlevels) {
      buttons.add(q.getButton());
    }
    return buttons;
  }
}

class Utilitiess {
  static String url = "";
  void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(

        content: Text(message),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ),
    );
  }
}
