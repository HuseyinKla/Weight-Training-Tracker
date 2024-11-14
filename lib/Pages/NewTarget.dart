import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weight_training_tracker/Classes/UserData.dart';

class NewTarget extends StatefulWidget {
  const NewTarget({Key? key}) : super(key: key);

  @override
  State<NewTarget> createState() => _NewTargetState();
}

class _NewTargetState extends State<NewTarget> {
  int currentWeight = int.parse(UserData.getUserKilo!);
  int targetWeight = int.parse(UserData.getUserKilo!) - 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Hedef"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Mevcut Kilo: $currentWeight kg',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Slider(
              value: currentWeight.toDouble(),
              min: 30,
              max: 250,
              divisions: 150,
              onChanged: (double value) {
                setState(() {
                  currentWeight = value.toInt();
                  if (targetWeight >= currentWeight) {
                    targetWeight = currentWeight - 1;
                  }
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Icon(Icons.remove),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  onPressed: () {
                    setState(() {
                      if (currentWeight > targetWeight + 1) {
                        currentWeight--;
                      }
                    });
                  },
                ),
                ElevatedButton(
                  child: Icon(Icons.add),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    setState(() {
                      if (currentWeight < 250) {
                        currentWeight++;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                'Hedef Kilo: $targetWeight kg',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Slider(
              value: targetWeight.toDouble(),
              min: 29,
              max: (currentWeight - 1).toDouble(),
              divisions: currentWeight - 1,
              onChanged: (double value) {
                setState(() {
                  targetWeight = value.toInt();
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (targetWeight > 29) {
                        targetWeight--;
                      }
                    });
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (targetWeight < currentWeight - 1) {
                        targetWeight++;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              padding: EdgeInsetsDirectional.only(start: 290),
              child: ElevatedButton(
                child: Text("Kaydet"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.blueAccent)),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("People")
                      .doc(UserData.getUserUid())
                      .update({
                    'target kilo': targetWeight,
                  });
                  int gap = currentWeight - targetWeight;
                  if (gap <= 5) {
                    UserData.setUserGap('1');
                  } else if (gap <= 10) {
                    UserData.setUserGap('2');
                  } else if (gap <= 15) {
                    UserData.setUserGap('3');
                  } else {
                    UserData.setUserGap('4');
                  }
                  UserData.setUserTargetKilo(targetWeight.toString());
                  showKaydedildiPopup(context);
                  Navigator.popAndPushNamed(context, "/main");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showKaydedildiPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Bilgi'),
        content: Text('İşlemler kaydedildi.'),
        actions: <Widget>[
          TextButton(
            child: Text('Tamam'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
