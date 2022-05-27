import 'package:flutter/material.dart';
import 'Screens/levels.dart';
import 'Screens/quiz.dart';
import 'Screens/quizlist.dart';
import 'Utiles/Utilities.dart';
import 'data/source/data_api.dart';
import 'data/source/question.dart';

void main() async {
  var data = await Downloader.getData("rakesh.itrplus.com",
      "/public/sachinkaflutter/quizzeslist.json");
  var quizzes = data["quizzes"];
  int n = quizzes.length;
  for (int i = 0; i <= n - 1; i++) { String name = quizzes[i]["name"];
  String base = quizzes[i]["base"];
  String path = quizzes[i]["path"];
  QuizList quizList = QuizList(base: base, name: name, path: path);
  Utilities.quizzeslist.add(quizList);
  }
  print(Utilities.quizzeslist);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => VsjQuizTypes(),
      '/level': (context) => Levelss(),
      '/quiz': (context) => VSJQuizApp12(),
    },
  ));
}
