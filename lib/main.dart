import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:mcq_try/drawer.dart';

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
//************************************************

class VsjQuizTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navidrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120,
        shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(30)),
        foregroundColor:  Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Programming Quiz',
          style: const TextStyle(
            height: 3,
            letterSpacing: 1.0,
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            childAspectRatio: 4/4,
            // crossAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          children: Utilities.getButtons(),
        ),
      ),
    );
  }
}
//************************************************
class Downloader {
  static Future<dynamic> getData(String base, String part) async {
    Uri url = Uri.http(base, part, {});
    try {
      final response = await http.get(url);
      print(response.body);
      final jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

//************************************************

//************************************************

//************************************************
class Utilities {
  static List<Question> questionlist=[];
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

class Question {
  final String question, opta, optb, optc, optd;
  final int correctAnswer;

  Question({required this.question,required this.correctAnswer,required this.opta,required this.optb,required this.optc,required this.optd});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        question: json['question'] as String,
        correctAnswer: (int.tryParse(json['correctanswer'].toString()) == null)
            ? 0
            : int.parse(json['correctanswer'].toString()),
        opta: json['opta'] as String,
        optb: json['optb'] as String,
        optc: json['optc'] as String,
        optd: json['optd'] as String);
  }
  @override
  String toString() { return "Question=" + question + ", Correct Answer=" + correctAnswer.toString();
  }
}
//************************************************
class QuizList {

  final String name, base, path;
  QuizList({required this.name, required this.base, required this.path});
  Widget getButton() {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            primary:  Color(0xFF1C2341),
          ),
          child: Image(height: 200, image: NetworkImage(name)),
          onPressed: () async {
            //print(base + path);
            try {
              var data = await Downloader.getData(base, path);
              //print(data.length);
              data=data["quizzes"];
              //*******************************************************************
              int n = data.length;
              print("n=$n");
              Utilities.quizlevels.clear();
              for (int i = 0; i <= n - 1; i++) {
                String name = data[i]["name"];
                String link = data[i]["link"];
                String base = data[i]["base"];
                Levels levels=Levels(link:link,name:name,base:base);

                Utilities.quizlevels.add(levels);
                print(name);
                print(base);
                print(link);
              }
              //*****************************************************************8**
              Navigator.pushNamed(context, '/level');
            } catch(ex) {
              print(ex);
            }
          },
        ),
      );
    });
  }
  @override
  String toString() {
    return "Name = $name, Base = $base, Path=$path";
  }
}
//************************************************//*******************************VsjTwo************************************//***********************
//*******************************VsjTwo************************************//*******************************VsjTwo************************************
class Levelss extends StatefulWidget {
  @override
  _VsjQuizState createState() {
    return _VsjQuizState();
  }
}
class _VsjQuizState extends State<Levelss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(30)),
        foregroundColor:  Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Levels',
          style: const TextStyle(
            height: 3,
            letterSpacing: 1,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ListView(
          children: Utilities.getLevelButtons(),
        ),
      ),
    );
  }
}
//************************************************
//************************************************

class Levels {
  final String name, link, base;
  Levels({required this.name, required this.link, required this.base});
  Widget getButton() {
    return Builder(builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton( style: ElevatedButton.styleFrom(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              primary:  Color(0xFF1C2341),
              fixedSize: Size(400, 70)
          ),
            child: Text(name),
            onPressed: () async {
              try {
                print("Level Click");
                var data = await Downloader.getData(base, link);
                data = data["questions"];
                print("**********************************************************************************");
                print(data);
                int x=data.length;
                print(x);
                Utilities.questionlist.clear();
                for(int i =0; i<=x-1; i++)
                {
                  Question q=Question.fromJson(data[i]);
                  Utilities.questionlist.add(q);
                }
                print(Utilities.questionlist);
                //*******************************************************************
                int n = data.length;
                print("n=$n");

                for (int i = 0; i <= n - 1; i++) {
                  String question = data[i]["question"];
                  String opta = data[i]["opta"];
                  String optb = data[i]["optb"];
                  String optc = data[i]["optc"];
                  String optd = data[i]["optd"];
                  String correctanswer = data[i]["correctanswer"];

                  print(question);
                  print(opta);
                  print(optb);
                  print(optc);
                  print(optd);
                  print(correctanswer);
                }
                //*****************************************************************8**
                Navigator.pushNamed(context, '/quiz');
              } catch(ex) {
                print(ex);
              }
            },
          ),
        ),
      );
    });
  }
  @override
  String toString() {
    return "Name = $name, Base = $base, link=$link";
  }
}

//************************************************


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

      //Downloader downloader = Downloader();
      isvisible = false;
      // var downloadresult = await downloader.getDownloadedData();
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

class QuestionArray {
  static List<Question> questions= [];

}

// class Question {
//   final String question, opta, optb, optc, optd;
//   final int correctAnswer;

//   Question(
//        {required this.question,
//         required this.correctAnswer,
//         required this.opta,
//         required this.optb,
//         required this.optc,
//         required this.optd});

//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//         question: json['question'] as String,
//         correctAnswer: (int.tryParse(json['correctanswer'].toString()) == null)
//             ? 0
//             : int.parse(json['correctanswer'].toString()),
//         opta: json['opta'] as String,
//         optb: json['optb'] as String,
//         optc: json['optc'] as String,
//         optd: json['optd'] as String);
// }
//   @override
//   String toString() { return "Question=" + question + ", Correct Answer=" + correctAnswer.toString();
//   }
// }

class QuestionsArray {
  final List<dynamic> questionlist;

  QuestionsArray({required this.questionlist});

  factory QuestionsArray.fromJson(Map<String, dynamic> json) {
    return QuestionsArray(questionlist: json['questions'] as List<dynamic>);
  }
}

class Utilitiess {
  static String url="";
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
