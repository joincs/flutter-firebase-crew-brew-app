import 'package:brewCrew/models/user.dart';
import 'package:brewCrew/screens/wrapper.dart';
import 'package:brewCrew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: "Brew Crew",
        theme: ThemeData(
          primaryColor: Colors.brown[400],
        ),
        home: Wrapper(),
      ),
    );
  }
}
