import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weight_training_tracker/Classes/UserData.dart';
import 'package:weight_training_tracker/Pages/NewTarget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('PZT', style: style);
        break;
      case 1:
        text = const Text('SAL', style: style);
        break;
      case 2:
        text = const Text('ÇRŞ', style: style);
        break;
      case 3:
        text = const Text('PRŞ', style: style);
        break;
      case 4:
        text = const Text('CUM', style: style);
        break;
      case 5:
        text = const Text('CMR', style: style);
        break;
      case 6:
        text = const Text('PAZ', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NewTarget()),
              );
            },
            icon: Icon(Icons.add_outlined, size: 35),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  UserData.getUserName!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  UserData.getUserSurname!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(top: 50, start: 25, end: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      UserData.getUserKilo!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Text("Kilo"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      UserData.getUserAge!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Text("Yaş"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      UserData.getUserVKI!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Text("VKİ"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(
                top: 20, start: 25, bottom: 25, end: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      UserData.getUserFatRatio!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Text("Yağ Oranı"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      UserData.getUserWaistRatio!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Text("Bel Oranı"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      UserData.getUserHipRatio!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    Text("Kalça Oranı"),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Container(
                height: 270,
                width: 600,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: bottomTitleWidgets,
                        ),
                      ),
                    ),
                    maxX: 7,
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: UserData.pastKilos
                            .asMap()
                            .entries
                            .map((entry) =>
                                FlSpot(entry.key.toDouble(), entry.value ?? 0))
                            .toList(),
                        isCurved: false,
                        barWidth: 3,
                        color: Colors.indigo,
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
