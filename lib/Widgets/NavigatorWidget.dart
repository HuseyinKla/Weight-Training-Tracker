import 'package:flutter/material.dart';
import 'package:weight_training_tracker/Pages/MainPage.dart';
import 'package:weight_training_tracker/Pages/ProfilePage.dart';
import 'package:weight_training_tracker/Pages/TrainingPage.dart';
import 'package:weight_training_tracker/Pages/WeightPage.dart';

class NavigatorWidget extends StatefulWidget {
  const NavigatorWidget({Key? key}) : super(key: key);

  @override
  State<NavigatorWidget> createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              MainPage(),
              TrainingPage(),
              WeightPage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xFF3F5AA6),
      child: TabBar(
        labelColor: Colors.white,
        labelStyle: TextStyle(fontSize: 11),
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        labelPadding: EdgeInsetsDirectional.all(4),
        tabs: <Widget>[
          Tab(
            text: "Ana Sayfa",
            icon: Icon(Icons.home_outlined),
          ),
          Tab(
            text: "Egzersizler",
            icon: Icon(
              Icons.fitness_center_outlined,
            ),
          ),
          Tab(
            text: "Kalori",
            icon: Icon(
              Icons.set_meal_outlined,
            ),
          ),
          Tab(
            text: "Profil",
            icon: Icon(
              Icons.account_circle_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
