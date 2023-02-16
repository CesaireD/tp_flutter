
import 'package:tp1/screens/CreateTodoScreen.dart';
import 'package:tp1/screens/home_screen.dart';
import 'package:tp1/screens/login_screen.dart';
import 'package:tp1/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '';

  final firstPage = token == '' ? 'LOGIN' : 'HOME';

  runApp(MyApp(firstPage: firstPage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firstPage});

  final String firstPage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateTodoScreen()
      //firstPage == 'LOGIN' ? const LoginScreen() : const HomeScreen(),
    );
  }
}