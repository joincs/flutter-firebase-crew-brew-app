import 'package:brewCrew/models/brew.dart';
import 'package:brewCrew/models/user.dart';
import 'package:brewCrew/screens/home/brew_list.dart';
import 'package:brewCrew/screens/home/settings_form.dart';
import 'package:brewCrew/services/auth.dart';
import 'package:brewCrew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    void _showSettingPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 60,
            ),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(user.uid).brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("Brew Crew"),
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"),
            ),
            FlatButton.icon(
              onPressed: () => _showSettingPanel(),
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
