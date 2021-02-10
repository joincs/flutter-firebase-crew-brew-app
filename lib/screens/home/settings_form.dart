import 'package:brewCrew/models/user.dart';
import 'package:brewCrew/services/database.dart';
import 'package:brewCrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final List<String> sugars = ['0', '1', '2', '3', '4'];

    String _currentName;
    String _currentSugars;
    int _currentStrength;

    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(user.uid).userData,
      builder: (conntext, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew Settings',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.name,
                  validator: (val) =>
                      val.isEmpty ? 'Please Enter a name' : null,
                  onChanged: (val) {
                    setState(() => _currentName = val);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //dropDown
                DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugar,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text("$sugar sugars"),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => _currentSugars = val);
                  },
                ),
                //Slider
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) {
                    setState(
                      () => _currentStrength = val.round(),
                    );
                  },
                ),
                //Button
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Updata",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(user.uid).updateUserData(
                        _currentSugars ?? userData.sugar,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
