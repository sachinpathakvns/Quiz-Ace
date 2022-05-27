import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utiles/Utilities.dart';
import '../data/source/data_api.dart';
import '../data/source/question.dart';
import '../main.dart';


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
        title: Text(
          'Levels',
          style: const TextStyle(
            height: 3,
            letterSpacing: 1,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
