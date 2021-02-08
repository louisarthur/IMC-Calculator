import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({this.userName, this.sex});
  final String userName;
  final bool sex;
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF444444),
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/splash.png'),
              Text(
                'Em construção',
                style: TextStyle(
                    decoration: TextDecoration.none, color: Colors.white38),
              )
            ],
          ),
        ));
  }
}
