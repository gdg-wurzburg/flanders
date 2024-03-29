import 'package:flanders/model/user.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserPreferencesPage extends StatefulWidget {
  UserPreferencesPage({Key key, this.user}) : super(key: key) {}

  final String title = "User Preferences";
  final User user;

  @override
  _UserPreferencesPageState createState() => _UserPreferencesPageState();
}

class _UserPreferencesPageState extends State<UserPreferencesPage> {
  var avatars = [
    "assets/avatars/CowboyCoder.flr",
    "assets/avatars/Designer.flr",
    "assets/avatars/ProgramManager.flr",
    "assets/avatars/Sourcerer.flr",
    "assets/avatars/Tester.flr",
    "assets/avatars/TheArchitect.flr",
    "assets/avatars/TheHacker.flr",
    "assets/avatars/TheJack.flr",
    "assets/avatars/TheRefactorer.flr",
  ];
  var avatarRotationIndex = 0;

  getAvatar() {
    if (0 <= avatarRotationIndex && avatarRotationIndex < avatars.length) {
      return avatars[avatarRotationIndex];
    }
    avatarRotationIndex = 0;
    return avatars[avatarRotationIndex];
  }

  TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    avatarRotationIndex = 0;

    if (widget.user != null) {
      if (widget.user.avatarId != null) {
        avatarRotationIndex = int.parse(widget.user.avatarId);
      }
      this.nicknameController.text = widget.user.nickname;
      this.nicknameController.addListener(() {
        widget.user.nickname = this.nicknameController.text;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                setState(() {
                  avatarRotationIndex = (avatarRotationIndex == avatars.length
                      ? 0
                      : avatarRotationIndex + 1);
                });
              },
              child: CircleAvatar(
                child: FlareActor(getAvatar()),
                minRadius: 80,
                maxRadius: 120,
              ),
            ),
            TextField(
              controller: nicknameController,
              decoration: InputDecoration(labelText: 'Nickname'),
            ),

          ],
        ));
  }

}
