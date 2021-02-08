import 'package:flutter/material.dart';

class AppBarCustom extends StatefulWidget {
  const AppBarCustom({this.controllerW, this.controllerH});

  final TextEditingController controllerW;
  final TextEditingController controllerH;

  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFF7159C1),
        actions: [
          IconButton(
            icon: Icon(Icons.rotate_left),
            onPressed: () {
              widget.controllerH.clear();
              widget.controllerW.clear();
            },
          )
        ],
        elevation: 20,
        centerTitle: true,
        title: Text('LiFitness'));
  }
}
