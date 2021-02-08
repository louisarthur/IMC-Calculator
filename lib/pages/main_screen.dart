import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imccalculator/localwidgets/AppBarCustom.dart';
import 'package:imccalculator/localwidgets/drawerCustom.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({this.userName, this.sex});
  final String userName;
  final bool sex;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controllerTextWeight = TextEditingController();
  TextEditingController controllerTextHeight = TextEditingController();
  final MaskTextInputFormatter formatter =
      MaskTextInputFormatter(mask: '#.##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF444444),
        drawer: DrawerCustom(userName: widget.userName, userSex: widget.sex),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBarCustom(
                controllerW: controllerTextWeight,
                controllerH: controllerTextHeight)),
        body: _body);
  }

  Widget get _body {
    return Center(
      child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Wrap(alignment: WrapAlignment.center, children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'images/splash.png',
                      scale: 2.0,
                    ),
                    Text(
                      'IMC - Calculator',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controllerTextWeight,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Preencha o peso!';
                      }
                      return null;
                    },
                    maxLength: 5,
                    decoration: InputDecoration(
                      labelText: 'Peso/KG',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color(0xFF7159C1),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, cut: true, selectAll: true),
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controllerTextHeight,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Preencha a altura!';
                      }
                      return null;
                    },
                    maxLength: 4,
                    inputFormatters: [formatter],
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      labelText: 'Altura/Metros',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Color(0xFF7159C1),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, cut: true, selectAll: true),
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ButtonTheme(
                    height: 45,
                    minWidth: 250,
                    child: RaisedButton(
                      disabledColor: Colors.grey,
                      onPressed: () async => imcFunction(
                          controllerTextWeight.text, formatter.getMaskedText()),
                      color: Color(0xFF7159C1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 10,
                      child: Text('Calcular',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ]))),
    );
  }

  Future<void> imcFunction(String weight, String height) async {
    double heightParse = double.parse(height);
    double weightParse = double.parse(weight);
    if (_formKey.currentState.validate()) {
      print('$heightParse || $weightParse ${pow(heightParse, 2)} $weightParse');
      double imc = weightParse / (pow(heightParse, 2));
      String message;
      Color colorToShow;
      if (imc < 18.5) {
        message = 'abaixo do peso';
        colorToShow = Colors.orange;
      } else if (18.5 < imc && imc < 24.9) {
        message = 'com o peso normal';
        colorToShow = Colors.green;
      } else if (25 < imc && imc < 29.9) {
        message = 'com sobrepeso';
        colorToShow = Colors.orange;
      } else if (30.0 < imc && imc < 34.9) {
        message = 'com obesidade grau 1';
        colorToShow = Colors.orangeAccent;
      } else if (35 < imc && imc < 39.9) {
        message = 'com obesidade grau 2';
        colorToShow = Colors.red;
      } else if (imc >= 40) {
        message = 'com obesidade grau 3 ou mórbida';
        colorToShow = Colors.redAccent;
      }

      Fluttertoast.showToast(
          msg:
              'O valor do seu IMC foi:${imc.toStringAsFixed(1)}, você está $message',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: colorToShow,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
