import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class navidrawer extends StatelessWidget {
  navidrawer({Key? key}) : super(key: key);
  final padding = EdgeInsets.symmetric(horizontal: 15);
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
                backgroundColor: Colors.white,
                radius: 80,
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
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => VsjQuizTypes(),
              ));}
        ),
        ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () { Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VsjQuizTypes(),
            ));}
        ),
        ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () { Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VsjQuizTypes(),
            ));}
        ),
        const Divider(
          color: Colors.black,
        ),
        ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            onTap: () { Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>VsjQuizTypes(),
            ));}
        ),
      ],
    ),
  );
}

//**********************************************************
//**********************************************************
Widget buildMenuitem({
  required String text,
  required Function() onClicked,
  required IconData icon,
}) {
  final color = Colors.white;
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(text, style: TextStyle(color: Colors.white)),
    onTap: onClicked,
  );
}
