import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imccalculator/pages/todo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({this.userSex = true, this.userName = 'Usuário'});
  final bool userSex;
  final String userName;
  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String get _userSexProfilePicture {
    if (widget.userSex) {
      return 'images/profile_male.jpg';
    } else {
      return 'images/profile_female.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                _topDrawer,
                _optionDrawer(Icon(Icons.bar_chart), 'Estatísticas', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodoScreen(
                              sex: widget.userSex,
                              userName: widget.userName,
                            )),
                  );
                }),
                _optionDrawer(Icon(Icons.settings), 'Configurações', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodoScreen(
                              sex: widget.userSex,
                              userName: widget.userName,
                            )),
                  );
                }),
              ],
            ),
            Column(
              children: [
                Divider(
                  color: Color(0xFF999999),
                ),
                _optionDrawer(Icon(Icons.exit_to_app), 'Sair', () async {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                  ));
                  final SharedPreferences prefs = await _prefs;
                  prefs.clear();
                  SystemNavigator.pop();
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _optionDrawer(Icon icon, String name, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[icon, SizedBox(width: 25), Text(name)],
        ),
      ),
    );
  }

  Widget get _topDrawer {
    return Container(
        color: Color(0xFF444444),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Stack(alignment: Alignment.center, children: <Widget>[
                Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF7159C1),
                      shape: BoxShape.circle,
                    )),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Color(0xFF7159C1),
                  backgroundImage: ExactAssetImage(
                    _userSexProfilePicture,
                  ),
                )
              ]),
              SizedBox(height: 10),
              Text(
                '${widget.userName}',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 2.0),
              ),
              Text(
                widget.userSex ? 'Masculino' : 'Feminino',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    wordSpacing: 2.0),
              ),
              SizedBox(height: 10)
            ],
          ),
        ));
  }
}
