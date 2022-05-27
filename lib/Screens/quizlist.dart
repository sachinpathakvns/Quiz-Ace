import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utiles/Utilities.dart';
import '../Widgets/drawer.dart';
import '../data/source/data_api.dart';
import 'levels.dart';


class VsjQuizTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: first(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(30)),
        foregroundColor:  Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Programming Quiz',
          style: TextStyle(
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