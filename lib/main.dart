import 'package:flutter/material.dart';
import 'package:flutter_app_offline/database/database.dart';
import 'package:flutter_app_offline/home_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(


      ),
      home: InviteApp(),
    );
  }
}

