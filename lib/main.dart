import 'package:flutter/material.dart';
import 'package:atividadedouglas/widgets/category_selection_screen.dart';
import 'package:atividadedouglas/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyQuizApp());
}

class MyQuizApp extends StatelessWidget {
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> userData = snapshot.data as Map<String, dynamic>;
              user.xp = userData['xp'];
              user.calculateLevel();
            }
            return CategorySelectionScreen(user: user);
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int xp = prefs.getInt('userXP') ?? 0;
    return {'xp': xp};
  }
}
