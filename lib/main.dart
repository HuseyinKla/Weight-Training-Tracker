import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weight_training_tracker/Widgets/NavigatorWidget.dart';

import 'Pages/StartPage.dart';
import 'Pages/WeightPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Training Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/main': (context) => NavigatorWidget(),
        '/': (context) => StartPage(),
        '/addMeal': (context) => AddMealDetailsScreen(),
      },
    );
  }
}

class General extends StatefulWidget {
  const General({Key? key}) : super(key: key);

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  bool _veri = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    kontrolEt();
  }

  void kontrolEt() async {
    Navigator.pushReplacementNamed(context, '/start');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container();
  }
}
