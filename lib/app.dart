import 'package:crud/screens/login.dart';
import 'package:flutter/material.dart';
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD APPLICATION DEMO',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
