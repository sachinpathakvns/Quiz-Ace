import 'package:flutter/material.dart';
import 'package:mcq_try/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screens/quiz.dart';
import '../Screens/quizlist.dart';
import 'drawer.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);
  @override
  _firstState createState() => _firstState();
}
class _firstState extends State<first> {
  Future<void>? _launched;

  Future<void> _sendEMail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: 'pathkaksachin@gmail.com',
      query: 'subject=Hi sachin &body=Glad to meet you', //add subject and body here
    );
    await launchUrl(launchUri);
  }
  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuitem(context),
        ],
      ),
    ),
  );
  Widget buildHeader(BuildContext context) => Material(
      child: InkWell(
        child: Container(
          color: Colors.black45,
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: const [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('http://rakesh.itrplus.com/public/sachinkaflutter/on.png'),
              ),
              SizedBox(height: 12),
              Text(
                "Programming Quiz",
                style: TextStyle(fontSize: 20,color: Colors.black),
              ),
            ],
          ),
        ),
      )
  );

  Widget buildMenuitem(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    child: Wrap(
      runSpacing: 15,
      children: [
        ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () { Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VsjQuizTypes(),
            ));}
        ),
        ListTile(
          onTap: () => setState(() {
            _launched = _sendEMail("EMail");
          }),
          leading: const Icon(Icons.email),
          title: const Text('Email'),
        )
      ],
    ),
  );

}

