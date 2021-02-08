import 'package:flutter/material.dart';
import 'package:imccalculator/pages/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dropdownValue = 'Masculino';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hasErrorOnForm = false;
  bool isMale = true;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController controllerText = new TextEditingController();

  Future<bool> setCredentialsOnLocalStorage(String name) async {
    final SharedPreferences prefs = await _prefs;
    bool isOKCredential = await prefs
        .setString(
      'credentials',
      name,
    )
        .then((value) {
      return true;
    });
    bool isOkSex = await prefs.setBool('sex', isMale).then((value) {
      return true;
    });

    if (isOkSex && isOKCredential) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF222222),
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(
                        'images/splash.png',
                        scale: 2.0,
                      ),
                      Text(
                        'LiFitiness',
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
                      controller: controllerText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor, digite o seu nome!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                            color:
                                hasErrorOnForm ? Colors.red : Color(0xFF7159C1),
                            fontSize: 17),
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.person,
                          color: hasErrorOnForm ? Colors.red : Colors.white70,
                        ),
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
                  _genreOptions,
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ButtonTheme(
                      height: 45,
                      minWidth: 250,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              hasErrorOnForm = false;
                            });
                            bool isOk = await setCredentialsOnLocalStorage(
                                controllerText.text);
                            print(isOk);
                            if (isOk) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen(
                                          sex: isMale,
                                          userName: controllerText.text,
                                        )),
                              );
                            }
                          } else {
                            setState(() {
                              hasErrorOnForm = true;
                            });
                          }
                        },
                        color: Color(0xFF7159C1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 10,
                        child: Text('Entrar',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _genreOptions {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ButtonTheme(
              height: 120,
              minWidth: MediaQuery.of(context).size.width * 0.35,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    isMale = true;
                  });
                },
                color: isMale ? Color(0xFF7159C1) : Color(0xFF333333),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Image.asset('images/male.png', scale: 5.0),
                    Text('Masculino',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ButtonTheme(
              height: 120,
              minWidth: MediaQuery.of(context).size.width * 0.35,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    isMale = false;
                  });
                },
                color: !isMale ? Color(0xFF7159C1) : Color(0xFF333333),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Column(
                  children: [
                    Image.asset('images/female.png', scale: 5.0),
                    Text('Feminino',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
          )
        ]);
  }
}
